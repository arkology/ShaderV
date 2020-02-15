tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeUVtwirl

func _init() -> void:
	set_input_port_default_value(1, 1.0)
	set_input_port_default_value(2, Vector3(0.5, 0.5, 0))

func _get_name() -> String:
	return "TwirlUV"

func _get_category() -> String:
	return "UV"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return "Twirl UV by value relative to pivot point"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 3

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "value"
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
vec3 twirlUVFunc(vec2 _uv_twirlUVFunc, vec2 _pivot_twirlUVFunc, float _amount_twirlUVFunc){
	_uv_twirlUVFunc -= _pivot_twirlUVFunc;
	float _angle_twirlUVFunc = atan(_uv_twirlUVFunc.y, _uv_twirlUVFunc.x);
	float _radiusTemp_twirlUVFunc = length(_uv_twirlUVFunc);
	_angle_twirlUVFunc += _radiusTemp_twirlUVFunc * _amount_twirlUVFunc;
	return vec3(_radiusTemp_twirlUVFunc * vec2(cos(_angle_twirlUVFunc), sin(_angle_twirlUVFunc)) + 0.5, 0.0);
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return output_vars[0] + " = twirlUVFunc(%s.xy, %s.xy, %s);" % [input_vars[0], input_vars[2], input_vars[1]]
