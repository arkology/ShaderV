tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeUVrotate

func _init() -> void:
	set_input_port_default_value(1, 0.0)
	set_input_port_default_value(2, Vector3(0.5, 0.5, 0))

func _get_name() -> String:
	return "RotateUV"

func _get_category() -> String:
	return "UV"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return "Rotate UV by angle in radians relative to pivot vector"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 3

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "angle"
		2:
			return "pivot"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
		2:
			return VisualShaderNode.PORT_TYPE_VECTOR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "uv"

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_global_code(mode: int) -> String:
	return """
vec3 r0tateUVFunc(vec3 _uv_r0tate, vec2 _pivot_r0tate, float _r0tation_r0tate){
	//_r0tation_r0tate = radians(_r0tationDeg_r0tate);
	vec2 _r0tAngle = vec2(cos(_r0tation_r0tate), sin(_r0tation_r0tate));
	_uv_r0tate.xy -= _pivot_r0tate;
	_uv_r0tate.xy = vec2((_uv_r0tate.x*_r0tAngle.x-_uv_r0tate.y*_r0tAngle.y),(_uv_r0tate.x*_r0tAngle.y+_uv_r0tate.y*_r0tAngle.x));
	_uv_r0tate.xy += _pivot_r0tate;
	return _uv_r0tate;
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return output_vars[0] + " = r0tateUVFunc(%s, %s.xy, %s);" % [input_vars[0], input_vars[2], input_vars[1]]
