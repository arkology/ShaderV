vec2 _lensDistortionUV(vec2 _lens_uv, float _lens_factor){
	vec2 _pos_dist_lens = _lens_uv - 0.5;
	float _d1st_d1s_1en5 = length(_pos_dist_lens);
	if (_lens_factor > 0.0) // fisheye / barrel
		_lens_uv = vec2(0.5)+normalize(_pos_dist_lens)*tan(_d1st_d1s_1en5*_lens_factor)*0.70711/tan(0.70711*_lens_factor);
	else if (_lens_factor < 0.0) // antifisheye / pincushion
		_lens_uv = vec2(0.5)+normalize(_pos_dist_lens)*atan(_d1st_d1s_1en5*-_lens_factor*10.0)*0.5/atan(-_lens_factor*0.5*10.0);
	return _lens_uv;
}