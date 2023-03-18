float _hash2_generic2D(vec2 _p_hash2_generic) {
	return (fract(1e4 * sin(17.0 * _p_hash2_generic.x + _p_hash2_generic.y * 0.1) *
					(0.1 + abs(sin(_p_hash2_generic.y * 13.0 + _p_hash2_generic.x)))));
}

float _genericNoise2D(vec2 _x_generic2D) {
	vec2 _temp_i_generic2D = floor(_x_generic2D);
	vec2 _temp_f_generic2D = fract(_x_generic2D);

	float _a_g1n2 = _hash2_generic2D(_temp_i_generic2D);
	float _b_g1n2 = _hash2_generic2D(_temp_i_generic2D + vec2(1.0, 0.0));
	float _c_g1n2 = _hash2_generic2D(_temp_i_generic2D + vec2(0.0, 1.0));
	float _d_g1n2 = _hash2_generic2D(_temp_i_generic2D + vec2(1.0, 1.0));
	
	vec2 _u_g1n2 = _temp_f_generic2D * _temp_f_generic2D * (3.0 - 2.0 * _temp_f_generic2D);
	return (mix(_a_g1n2, _b_g1n2, _u_g1n2.x) + (_c_g1n2 - _a_g1n2) *
				_u_g1n2.y * (1.0 - _u_g1n2.x) + (_d_g1n2 - _b_g1n2) * _u_g1n2.x * _u_g1n2.y);
}