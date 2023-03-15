vec4 _outerGlowFunc(sampler2D _samp_inglow, vec2 _uv_inglow, float _lod_inglow, float _rad_inglow, float _intns_inglow, vec4 _col_inglow){
	_rad_inglow = abs(_rad_inglow);
	
	vec4 _color_inglow = vec4(0.0);
	float _alpha_inv = 0.0;
	float _alpha_inglow_b1 = 0.0;
	int _amount_inglow = 3;
	
	if (_lod_inglow < 0.0)
		_color_inglow = texture(_samp_inglow, _uv_inglow);
	else
		_color_inglow = textureLod(_samp_inglow, _uv_inglow, _lod_inglow);
	
	_amount_inglow = int(min(_rad_inglow + 7.0, 14.0));
	for(int x = - _amount_inglow; x <= _amount_inglow; x++) {
		for(int y = - _amount_inglow; y <= _amount_inglow; y++) {
			vec2 _coord_blur_cst = _uv_inglow + vec2(float(x), float(y)) * _rad_inglow * 0.01;
			_alpha_inglow_b1 += textureLod(_samp_inglow, _coord_blur_cst, 0.0).a;
		}
	}
	int _nmb_neighbours_blur_cst = (_amount_inglow * 2 + 1) * (_amount_inglow * 2 + 1);
	_alpha_inglow_b1 /= float(_nmb_neighbours_blur_cst);
	
	_alpha_inv = _alpha_inglow_b1; // inversion
	_alpha_inv *= (1.0 - _color_inglow.a); // masking
	
	if (_alpha_inv > 0.0)
		_alpha_inv *= (_intns_inglow + 1.0);
	
	vec4 _glow_col_result = vec4(_col_inglow.rgb, _alpha_inv * _col_inglow.a);
	return mix(_glow_col_result, _color_inglow, _color_inglow.a);
}