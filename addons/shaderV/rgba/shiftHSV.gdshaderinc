vec3 _hsv2rgbHSVChangeFunc(vec3 _hsv_color_HSVChange){
	vec4 _K_hsv2rgbHSVChange = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
	vec3 _p_hsv2rgbHSVChange = abs(fract(_hsv_color_HSVChange.xxx + _K_hsv2rgbHSVChange.xyz) * 6.0 - _K_hsv2rgbHSVChange.www);
	return vec3(_hsv_color_HSVChange.z * mix(_K_hsv2rgbHSVChange.xxx, 
				clamp(_p_hsv2rgbHSVChange - _K_hsv2rgbHSVChange.xxx, 0.0, 1.0),
				_hsv_color_HSVChange.y));
}

vec3 _rgb2hvsHSVChangeFunc(vec3 _rgb_color_HSVChange){
	vec4 _K_rgb2hvsHSVChange = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
	vec4 _p_rgb2hvsHSVChange = mix( vec4(_rgb_color_HSVChange.bg, _K_rgb2hvsHSVChange.wz),
									vec4(_rgb_color_HSVChange.gb, _K_rgb2hvsHSVChange.xy),
									step(_rgb_color_HSVChange.b, _rgb_color_HSVChange.g));
	vec4 _q_rgb2hvsHSVChange = mix( vec4(_p_rgb2hvsHSVChange.xyw, _rgb_color_HSVChange.r), 
									vec4(_rgb_color_HSVChange.r, _p_rgb2hvsHSVChange.yzx),
									step(_p_rgb2hvsHSVChange.x, _rgb_color_HSVChange.r));
	float _d_rgb2hvsHSVChange = _q_rgb2hvsHSVChange.x - min(_q_rgb2hvsHSVChange.w, _q_rgb2hvsHSVChange.y);
	return vec3(vec3(abs(_q_rgb2hvsHSVChange.z + (_q_rgb2hvsHSVChange.w - _q_rgb2hvsHSVChange.y) / (6.0 * _d_rgb2hvsHSVChange + 1.0e-10)),
					_d_rgb2hvsHSVChange / (_q_rgb2hvsHSVChange.x + 1.0e-10),
					_q_rgb2hvsHSVChange.x));
}

vec3 _hsvChangeHSVChangeFunc(vec3 _color_HSVChange, float _h_HSVChange, float _s_HSVChange, float _v_HSVChange){
	_color_HSVChange = _rgb2hvsHSVChangeFunc(_color_HSVChange);
	_color_HSVChange.r *= _h_HSVChange;
	_color_HSVChange.g *= _s_HSVChange;
	_color_HSVChange.b *= _v_HSVChange;
	return _hsv2rgbHSVChangeFunc(_color_HSVChange);
}