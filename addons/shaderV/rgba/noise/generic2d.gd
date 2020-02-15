tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeNoiseGeneric2d

func _init() -> void:
	set_input_port_default_value(1, Vector3(0, 0, 0))
	set_input_port_default_value(2, 5)

func _get_name() -> String:
	return "GenericNoise2D"

func _get_category() -> String:
	return "RGBA"

func _get_subcategory() -> String:
	return "Noise"

func _get_description() -> String:
	return "GenericNoise using hash random function"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_input_port_count() -> int:
	return 3

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "offset"
		2:
			return "scale"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "result"

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_global_code(mode: int) -> String:
	return """
float hash2_gener1c2D(vec2 _p_hash2_gener1c) {
	return (fract(1e4 * sin(17.0 * _p_hash2_gener1c.x + _p_hash2_gener1c.y * 0.1) *
					(0.1 + abs(sin(_p_hash2_gener1c.y * 13.0 + _p_hash2_gener1c.x)))));
}

float genericNoise2D(vec2 _x_gener1c2D) {
	vec2 _temp_i_gener1c2D = floor(_x_gener1c2D);
	vec2 _temp_f_gener1c2D = fract(_x_gener1c2D);

	float _a_g1n2 = hash2_gener1c2D(_temp_i_gener1c2D);
	float _b_g1n2 = hash2_gener1c2D(_temp_i_gener1c2D + vec2(1.0, 0.0));
	float _c_g1n2 = hash2_gener1c2D(_temp_i_gener1c2D + vec2(0.0, 1.0));
	float _d_g1n2 = hash2_gener1c2D(_temp_i_gener1c2D + vec2(1.0, 1.0));
	
	vec2 _u_g1n2 = _temp_f_gener1c2D * _temp_f_gener1c2D * (3.0 - 2.0 * _temp_f_gener1c2D);
	return (mix(_a_g1n2, _b_g1n2, _u_g1n2.x) + (_c_g1n2 - _a_g1n2) *
				_u_g1n2.y * (1.0 - _u_g1n2.x) + (_d_g1n2 - _b_g1n2) * _u_g1n2.x * _u_g1n2.y);
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s = genericNoise2D((%s.xy + %s.xy) * %s);" % [
	output_vars[0], input_vars[0], input_vars[1], input_vars[2]]
