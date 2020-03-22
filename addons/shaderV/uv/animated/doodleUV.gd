tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeUVdoodle

func _init() -> void:
	set_input_port_default_value(1, 0.5)
	set_input_port_default_value(2, 4.0)
	set_input_port_default_value(3, 0.7)
	set_input_port_default_value(4, 0.065)
	set_input_port_default_value(5, 0)

func _get_name() -> String:
	return "DoodleUV"

func _get_category() -> String:
	return "UV"

func _get_subcategory() -> String:
	return "Animated"

func _get_description() -> String:
	return "Doodle UV effect"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 6

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "frameTime"
		2:
			return "frameCount"
		3:
			return "lacunarity"
		4:
			return "maxOffset"
		5:
			return "time"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR
		3:
			return VisualShaderNode.PORT_TYPE_SCALAR
		4:
			return VisualShaderNode.PORT_TYPE_SCALAR
		5:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "uv"

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_global_code(mode: int) -> String:
	return """
float hash2D00dle(vec2 _p_hash_d00dle) {
	return fract(1e4 * sin(17.0 * _p_hash_d00dle.x + _p_hash_d00dle.y * 0.1) * (0.1 + abs(sin(_p_hash_d00dle.y * 13.0 + _p_hash_d00dle.x))));
}

float noiseD00dle(vec2 _seed_noise_d00dle){
	vec2 i = floor(_seed_noise_d00dle);
	vec2 f = fract(_seed_noise_d00dle);
	float _a = hash2D00dle(i);
	float _b = hash2D00dle(i + vec2(1.0, 0.0));
	float _c = hash2D00dle(i + vec2(0.0, 1.0));
	float _d = hash2D00dle(i + vec2(1.0, 1.0));
	vec2 u = f * f * (3.0 - 2.0 * f);
	return mix(_a, _b, u.x) + (_c - _a) * u.y * (1.0 - u.x) + (_d - _b) * u.x * u.y;
}

vec2 d00dleUVFunc(vec2 _uv_d00dle, float _max_offset_d00dle, float _time_d00dle, float _frame_time_d00dle, int _frame_count_d00dle, float _scale_d00dle){
	float timeValueD00dle = mod(floor(_time_d00dle / _frame_time_d00dle), float(_frame_count_d00dle)) + 1.0;
	return _uv_d00dle + vec2(noiseD00dle((_uv_d00dle + timeValueD00dle) * _scale_d00dle) * 2.0 - 1.0) * _max_offset_d00dle;
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s.xy = d00dleUVFunc(%s.xy, %s, %s, %s, int(%s), %s);" % [
	output_vars[0], input_vars[0], input_vars[4], input_vars[5], input_vars[1], input_vars[2], input_vars[3]]
