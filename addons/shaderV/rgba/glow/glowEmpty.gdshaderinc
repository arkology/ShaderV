vec4 _inoutGlowEmptyFunc(sampler2D _samp_inglowEmpt, vec2 _uv_inglowEmpt, float _lod_glowEmpt, float _rad_inout_Empty,
						float _intens_inner_glowEmpt, float _intens_outer_glowEmpt, vec4 _col_inglowEmpt){
	_rad_inout_Empty = abs(_rad_inout_Empty);
	
	vec4 _color_orig_glow = vec4(0.0);
	float _alpha_glow_inv = 0.0;
	float _alpha_glow_blured = 0.0;
	int glow_amount = 3;
	
	if (_lod_glowEmpt < 0.0)
		_color_orig_glow = texture(_samp_inglowEmpt, _uv_inglowEmpt);
	else
		_color_orig_glow = textureLod(_samp_inglowEmpt, _uv_inglowEmpt, _lod_glowEmpt);
	
	glow_amount = int(min(_rad_inout_Empty + 7.0, 14.0));
	for(int x = - glow_amount; x <= glow_amount; x++) {
		for(int y = - glow_amount; y <= glow_amount; y++) {
			vec2 _coord_blur_cst = _uv_inglowEmpt + vec2(float(x), float(y)) * _rad_inout_Empty * 0.01;
			_alpha_glow_blured += textureLod(_samp_inglowEmpt, _coord_blur_cst, 0.0).a;
		}
	}
	int _nmb_neighbours_blur_cst = (glow_amount * 2 + 1) * (glow_amount * 2 + 1);
	_alpha_glow_blured /= float(_nmb_neighbours_blur_cst);
	
	_alpha_glow_inv = _alpha_glow_blured;
	_alpha_glow_inv *= (1.0 - _color_orig_glow.a);
	
	float in_alpha_glow_inv = 1.0 - _alpha_glow_blured;
	in_alpha_glow_inv *= _color_orig_glow.a;
	
	if (_alpha_glow_inv > 0.0)
		_alpha_glow_inv *= (_intens_outer_glowEmpt + 1.0);
	
	if (in_alpha_glow_inv > 0.0)
		in_alpha_glow_inv *= (_intens_inner_glowEmpt + 1.0);
	
	return vec4(_col_inglowEmpt.rgb, (_alpha_glow_inv + in_alpha_glow_inv) * _col_inglowEmpt.a);
}