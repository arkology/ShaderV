tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeUVtwirl

func _get_name():
	return "TwirlUV"

func _get_category():
	return "UV"

#func _get_subcategory():
#	return ""

func _get_description():
	return "Twirl UV by value relative to pivot point"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count():
	return 3

func _get_input_port_name(port):
	match port:
		0:
			return "uv"
		1:
			return "value"
		2:
			return "pivot"

func _get_input_port_type(port):
	set_input_port_default_value(1, 1.0)
	set_input_port_default_value(2, Vector3(0.5, 0.5, 0))
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
		2:
			return VisualShaderNode.PORT_TYPE_VECTOR

func _get_output_port_count():
	return 1

func _get_output_port_name(port):
	return "uv"

func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_global_code(mode):
	return """
vec3 twirlUVFunc(vec2 _uv_twirlUVFunc, vec2 _pivot_twirlUVFunc, float _amount_twirlUVFunc){
	_uv_twirlUVFunc -= _pivot_twirlUVFunc;
	float _angle_twirlUVFunc = atan(_uv_twirlUVFunc.y, _uv_twirlUVFunc.x);
	float _radiusTemp_twirlUVFunc = length(_uv_twirlUVFunc);
	_angle_twirlUVFunc += _radiusTemp_twirlUVFunc * _amount_twirlUVFunc;
	return vec3(_radiusTemp_twirlUVFunc * vec2(cos(_angle_twirlUVFunc), sin(_angle_twirlUVFunc)) + 0.5, 0.0);
}
"""

func _get_code(input_vars, output_vars, mode, type):
	return output_vars[0] + " = twirlUVFunc(%s.xy, %s.xy, %s);" % [input_vars[0], input_vars[2], input_vars[1]]
