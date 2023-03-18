vec4 _zoomBlurFunc(sampler2D _tex_zoom_blur, vec2 _uv_zoom_blur, int _amount_zoom_blur, vec2 _center_zoom, float _lgt_zoom_blur, float _lod_zoom_blur){
	vec4 _col_zoom_blur;
	if (_lod_zoom_blur < 0.0){
		_col_zoom_blur = texture(_tex_zoom_blur, _uv_zoom_blur);
		for (int i = 1; i <= _amount_zoom_blur; i++){
			float _temp_d_zoom_blur = _lgt_zoom_blur * float(i);
			vec2 px = _uv_zoom_blur * (1.0 - _temp_d_zoom_blur) + _center_zoom * _temp_d_zoom_blur;
			_col_zoom_blur += texture(_tex_zoom_blur, px);
		}
	}else{
		_col_zoom_blur = textureLod(_tex_zoom_blur, _uv_zoom_blur, _lod_zoom_blur);
		for (int i = 1; i <= _amount_zoom_blur; i++){
			float _temp_d_zoom_blur = _lgt_zoom_blur * float(i);
			vec2 px = _uv_zoom_blur * (1.0 - _temp_d_zoom_blur) + _center_zoom * _temp_d_zoom_blur;
			_col_zoom_blur += textureLod(_tex_zoom_blur, px, _lod_zoom_blur);
		}
	}
	_col_zoom_blur = _col_zoom_blur / float(_amount_zoom_blur + 1);
	return _col_zoom_blur;
}