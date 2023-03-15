float _clampAlphaBorderFunc(float _color_alpha_clamp, vec2 _uv_clamp){
	_color_alpha_clamp = mix(0.0, _color_alpha_clamp, max(sign(_uv_clamp.x), 0.0));
	_color_alpha_clamp = mix(0.0, _color_alpha_clamp, max(sign(1.0 - _uv_clamp.x), 0.0));
	_color_alpha_clamp = mix(0.0, _color_alpha_clamp, max(sign(_uv_clamp.y), 0.0));
	_color_alpha_clamp = mix(0.0, _color_alpha_clamp, max(sign(1.0 - _uv_clamp.y), 0.0));
	return _color_alpha_clamp;
}