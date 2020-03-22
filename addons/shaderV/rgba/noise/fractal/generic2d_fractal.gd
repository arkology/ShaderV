tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeNoiseGeneric2dFractal

func _init() -> void:
	set_input_port_default_value(1, 6)
	set_input_port_default_value(2, Vector3(2, 2, 0))
	set_input_port_default_value(3, 2)
	set_input_port_default_value(4, 0.8)
	set_input_port_default_value(5, 0.5)
	set_input_port_default_value(6, 0.3)
	set_input_port_default_value(7, Vector3(0.5, 0.5, 0))

func _get_name() -> String:
	return "FractalGenericNoise2D"

func _get_category() -> String:
	return "RGBA"

func _get_subcategory() -> String:
	return "NoiseFractal"

func _get_description() -> String:
	return "Fractal GenericNoise using hash random function"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_input_port_count() -> int:
	return 8

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "octaves"
		2:
			return "period"
		3:
			return "lacunarity"
		4:
			return "persistence"
		5:
			return "angle"
		6:
			return "amplitude"
		7:
			return "shift"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
		2:
			return VisualShaderNode.PORT_TYPE_VECTOR
		3:
			return VisualShaderNode.PORT_TYPE_SCALAR
		4:
			return VisualShaderNode.PORT_TYPE_SCALAR
		5:
			return VisualShaderNode.PORT_TYPE_SCALAR
		6:
			return VisualShaderNode.PORT_TYPE_SCALAR
		7:
			return VisualShaderNode.PORT_TYPE_VECTOR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "result"

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_global_code(mode: int) -> String:
	return """
float hash2_gener1c2DFractal(vec2 _p_hash2_gener1c) {
	return (fract(1e4 * sin(17.0 * _p_hash2_gener1c.x + _p_hash2_gener1c.y * 0.1) *
					(0.1 + abs(sin(_p_hash2_gener1c.y * 13.0 + _p_hash2_gener1c.x)))));
}
float genericNoise2DFractal(vec2 _x_gener1c2D) {
	vec2 _temp_i_gener1c2D = floor(_x_gener1c2D);
	vec2 _temp_f_gener1c2D = fract(_x_gener1c2D);

	float _a_g1n2 = hash2_gener1c2DFractal(_temp_i_gener1c2D);
	float _b_g1n2 = hash2_gener1c2DFractal(_temp_i_gener1c2D + vec2(1.0, 0.0));
	float _c_g1n2 = hash2_gener1c2DFractal(_temp_i_gener1c2D + vec2(0.0, 1.0));
	float _d_g1n2 = hash2_gener1c2DFractal(_temp_i_gener1c2D + vec2(1.0, 1.0));
	
	vec2 _u_g1n2 = _temp_f_gener1c2D * _temp_f_gener1c2D * (3.0 - 2.0 * _temp_f_gener1c2D);
	return (mix(_a_g1n2, _b_g1n2, _u_g1n2.x) + (_c_g1n2 - _a_g1n2) *
				_u_g1n2.y * (1.0 - _u_g1n2.x) + (_d_g1n2 - _b_g1n2) * _u_g1n2.x * _u_g1n2.y);
}
float genericNoise2DFBM(vec2 _uv_gnfbm, int _oct_gnfbm, vec2 _per_gnfbm, float _lac_gnfbm,
						float _persist_gnfbm, float _rot_gnfbm, float _ampl_gnfbm, vec2 _shift_gnfbm) {
	float _v = 0.0;
	float _a = _ampl_gnfbm;
	mat2 _r0t = mat2(vec2(cos(_rot_gnfbm), sin(_rot_gnfbm)), vec2(-sin(_rot_gnfbm), cos(_rot_gnfbm)));
	for (int i = 0; i < _oct_gnfbm; ++i) {
		_v += _a * genericNoise2DFractal(_uv_gnfbm * _per_gnfbm);
		_uv_gnfbm = _r0t * _uv_gnfbm * _lac_gnfbm + _shift_gnfbm;
		_a *= _persist_gnfbm;
	}
	return _v;
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s = genericNoise2DFBM(%s.xy, int(%s), %s.xy, %s, %s, %s, %s, %s.xy);" % [
	output_vars[0], input_vars[0], input_vars[1], input_vars[2], input_vars[3],
	input_vars[4], input_vars[5], input_vars[6], input_vars[7]]
