float _hash2Doodle(vec2 _p_hash_doodle) {
	return fract(1e4 * sin(17.0 * _p_hash_doodle.x + _p_hash_doodle.y * 0.1) * (0.1 + abs(sin(_p_hash_doodle.y * 13.0 + _p_hash_doodle.x))));
}

float _noiseDoodle(vec2 _seed_noise_doodle){
	vec2 i = floor(_seed_noise_doodle);
	vec2 f = fract(_seed_noise_doodle);
	float _a = _hash2Doodle(i);
	float _b = _hash2Doodle(i + vec2(1.0, 0.0));
	float _c = _hash2Doodle(i + vec2(0.0, 1.0));
	float _d = _hash2Doodle(i + vec2(1.0, 1.0));
	vec2 u = f * f * (3.0 - 2.0 * f);
	return mix(_a, _b, u.x) + (_c - _a) * u.y * (1.0 - u.x) + (_d - _b) * u.x * u.y;
}

vec2 _doodleUVFunc(vec2 _doodle_uv, float _doodle_max_offset, float _doodle_time, float _doodle_frame_time, int _doodle_frame_count, float _doodle_scale){
	float _timeValueDoodle = mod(floor(_doodle_time / _doodle_frame_time), float(_doodle_frame_count)) + 1.0;
	return _doodle_uv + vec2(_noiseDoodle((_doodle_uv + _timeValueDoodle) * _doodle_scale) * 2.0 - 1.0) * _doodle_max_offset;
}