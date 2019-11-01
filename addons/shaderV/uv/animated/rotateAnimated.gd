tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeUVrotateAnimated

func _get_name():
	return "RotateUVAnim"

func _get_category():
	return "UV"

func _get_subcategory():
	return "Animated"

func _get_description():
	return "Animated UV rotation by angle in radians relative to pivot vector"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count():
	return 4

func _get_input_port_name(port):
	match port:
		0:
			return "uv"
		1:
			return "angularSpeed"
		2:
			return "pivot"
		3:
			return "time"

func _get_input_port_type(port):
	set_input_port_default_value(1, 0.5)
	set_input_port_default_value(2, Vector3(0.5, 0.5, 0))
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
		2:
			return VisualShaderNode.PORT_TYPE_VECTOR
		3:
			return VisualShaderNode.PORT_TYPE_SCALAR
		

func _get_output_port_count():
	return 1

func _get_output_port_name(port):
	return "uv"

func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_global_code(mode):
	return """
vec2 r0tateUVAnimatedFunc(vec2 _uv_r0tate, vec2 _pivot_r0tate, float _r0tation_r0tate, float _r0tSpeed_r0tate, float _t1me_r0tate){
	_r0tation_r0tate += _t1me_r0tate * _r0tSpeed_r0tate;
	//_r0tation_r0tate = radians(_r0tationDeg_r0tate);
	vec2 _r0tAngle = vec2(cos(_r0tation_r0tate), sin(_r0tation_r0tate));
	_uv_r0tate -= _pivot_r0tate;
	_uv_r0tate = vec2((_uv_r0tate.x*_r0tAngle.x-_uv_r0tate.y*_r0tAngle.y),(_uv_r0tate.x*_r0tAngle.y+_uv_r0tate.y*_r0tAngle.x));
	_uv_r0tate += _pivot_r0tate;
	return _uv_r0tate;
}
"""

func _get_code(input_vars, output_vars, mode, type):
	return output_vars[0] + " = vec3(r0tateUVAnimatedFunc(%s.xy, %s.xy, 0.0, %s, %s), 0);" % [
	input_vars[0], input_vars[2], input_vars[1], input_vars[3]]
