float _hash2_gener1c2DFractal(vec2 _p_hash2_gener1c) {
	return (fract(1e4 * sin(17.0 * _p_hash2_gener1c.x + _p_hash2_gener1c.y * 0.1) *
					(0.1 + abs(sin(_p_hash2_gener1c.y * 13.0 + _p_hash2_gener1c.x)))));
}
float _genericNoise2DFractal(vec2 _x_gener1c2D) {
	vec2 _temp_i_gener1c2D = floor(_x_gener1c2D);
	vec2 _temp_f_gener1c2D = fract(_x_gener1c2D);

	float _a_g1n2 = _hash2_gener1c2DFractal(_temp_i_gener1c2D);
	float _b_g1n2 = _hash2_gener1c2DFractal(_temp_i_gener1c2D + vec2(1.0, 0.0));
	float _c_g1n2 = _hash2_gener1c2DFractal(_temp_i_gener1c2D + vec2(0.0, 1.0));
	float _d_g1n2 = _hash2_gener1c2DFractal(_temp_i_gener1c2D + vec2(1.0, 1.0));
	
	vec2 _u_g1n2 = _temp_f_gener1c2D * _temp_f_gener1c2D * (3.0 - 2.0 * _temp_f_gener1c2D);
	return (mix(_a_g1n2, _b_g1n2, _u_g1n2.x) + (_c_g1n2 - _a_g1n2) *
				_u_g1n2.y * (1.0 - _u_g1n2.x) + (_d_g1n2 - _b_g1n2) * _u_g1n2.x * _u_g1n2.y);
}
float _genericNoise2DFBM(vec2 _uv_gnfbm, int _oct_gnfbm, vec2 _per_gnfbm, float _lac_gnfbm,
						float _persist_gnfbm, float _rot_gnfbm, float _ampl_gnfbm, vec2 _shift_gnfbm) {
	float _v = 0.0;
	float _a = _ampl_gnfbm;
	mat2 _r0t = mat2(vec2(cos(_rot_gnfbm), sin(_rot_gnfbm)), vec2(-sin(_rot_gnfbm), cos(_rot_gnfbm)));
	for (int i = 0; i < _oct_gnfbm; ++i) {
		_v += _a * _genericNoise2DFractal(_uv_gnfbm * _per_gnfbm);
		_uv_gnfbm = _r0t * _uv_gnfbm * _lac_gnfbm + _shift_gnfbm;
		_a *= _persist_gnfbm;
	}
	return _v;
}