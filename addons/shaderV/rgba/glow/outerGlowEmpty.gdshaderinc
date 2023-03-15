vec4 _outerGlowEmptyFunc(sampler2D _samp_inglowEmpt, vec2 _uv_inglowEmpt, float _lod_inglowEmpt, float _rad_inglowEmpt, float _intns_inglowEmpt, vec4 _col_inglowEmpt){
	_rad_inglowEmpt = abs(_rad_inglowEmpt);
	
	vec4 _color_inglow = vec4(0.0);
	float _alpha_inglow_inv = 0.0;
	float _alpha_inglow_b1 = 0.0;
	int _amount_inglow = 3;
	
	if (_lod_inglowEmpt < 0.0)
		_color_inglow = texture(_samp_inglowEmpt, _uv_inglowEmpt);
	else
		_color_inglow = textureLod(_samp_inglowEmpt, _uv_inglowEmpt, _lod_inglowEmpt);
	
	_amount_inglow = int(min(_rad_inglowEmpt + 7.0, 14.0));
	for(int x = - _amount_inglow; x <= _amount_inglow; x++) {
		for(int y = - _amount_inglow; y <= _amount_inglow; y++) {
			vec2 _coord_blur_cst = _uv_inglowEmpt + vec2(float(x), float(y)) * _rad_inglowEmpt * 0.01;
			_alpha_inglow_b1 += textureLod(_samp_inglowEmpt, _coord_blur_cst, 0.0).a;
		}
	}
	int _nmb_neighbours_blur_cst = (_amount_inglow * 2 + 1) * (_amount_inglow * 2 + 1);
	_alpha_inglow_b1 /= float(_nmb_neighbours_blur_cst);
	
	_alpha_inglow_inv = _alpha_inglow_b1; // inversion
	_alpha_inglow_inv *= (1.0 - _color_inglow.a); // masking
	
	if (_alpha_inglow_inv > 0.0)
		_alpha_inglow_inv *= (_intns_inglowEmpt + 1.0);
	
	return vec4(_col_inglowEmpt.rgb, _alpha_inglow_inv * _col_inglowEmpt.a);
}