tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeUVswirl

func _init() -> void:
	set_input_port_default_value(1, Vector3(0.5, 0.5, 0.0))
	set_input_port_default_value(2, 0.0)
	set_input_port_default_value(3, 0.0)

func _get_name() -> String:
	return "SwirlUV"

func _get_category() -> String:
	return "UV"

func _get_subcategory() -> String:
	return "Animated"

func _get_description() -> String:
	return "Swirl UV effect"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 4

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "pivot"
		2:
			return "strength"
		3:
			return "sin_time"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR
		3:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "uv"

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_global_code(mode: int) -> String:
	return """
vec2 swirlUVFunc(vec2 _uv_sw1rl, float _t1me_sw1rl, vec2 _p1vot_sw1rl, float _amount_sw1rl){
	float _rotation_index_sw1rl = _amount_sw1rl * length(_uv_sw1rl - _p1vot_sw1rl) * _t1me_sw1rl;
	_uv_sw1rl -= _p1vot_sw1rl;
	_uv_sw1rl *= mat2(vec2(cos(_rotation_index_sw1rl), - sin(_rotation_index_sw1rl)),
										vec2(sin(_rotation_index_sw1rl), cos(_rotation_index_sw1rl)));
	_uv_sw1rl += _p1vot_sw1rl;
	return _uv_sw1rl;
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s.xy = swirlUVFunc(%s.xy, %s, %s.xy, %s);" % [
	output_vars[0], input_vars[0], input_vars[3], input_vars[1], input_vars[2]]
