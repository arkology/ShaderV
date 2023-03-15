vec3 _normalFromHeightmapFunc(vec2 _hm_uv, sampler2D _hm_tex, vec2 _hm_size, float _norm_hm_strgth, bool _conv_hm_gray, bool _inv_x_norm, bool _inv_y_norm){
	vec3 _hm_down = textureLod(_hm_tex, _hm_uv + vec2(0.0, 1.0 / _hm_size.y), 0.0).rgb;
	vec3 _hm_up = textureLod(_hm_tex, _hm_uv - vec2(0.0, 1.0 / _hm_size.y), 0.0).rgb;
	vec3 _hm_right = textureLod(_hm_tex, _hm_uv + vec2(1.0 / _hm_size.x, 0.0), 0.0).rgb;
	vec3 _hm_left = textureLod(_hm_tex, _hm_uv - vec2(1.0 / _hm_size.x, 0.0), 0.0).rgb;
	
	if (_conv_hm_gray) {
		_hm_down.r = 0.2126 * _hm_down.r + 0.7152 * _hm_down.g + 0.0722 * _hm_down.b;
		_hm_up.r = 0.2126 * _hm_up.r + 0.7152 * _hm_up.g + 0.0722 * _hm_up.b;
		_hm_right.r = 0.2126 * _hm_right.r + 0.7152 * _hm_right.g + 0.0722 * _hm_right.b;
		_hm_left.r = 0.2126 * _hm_left.r + 0.7152 * _hm_left.g + 0.0722 * _hm_left.b;
	}
	
	float dx = (1.0 - float(_inv_x_norm)) * (_hm_left.r - _hm_right.r) + 
				(float(_inv_x_norm)) * (-_hm_left.r + _hm_right.r);
	float dy = (1.0 - float(_inv_y_norm)) * (_hm_up.r - _hm_down.r) + 
				(float(_inv_y_norm)) * (-_hm_up.r + _hm_down.r);
	
	return normalize(vec3(dx, dy, 1.0 / _norm_hm_strgth));
}