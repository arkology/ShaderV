vec3 blackNwhite(vec3 _input_rgb_color, float _threshold_color){
	return vec3( ( (0.21 * _input_rgb_color.r + 0.71 * _input_rgb_color.g + 0.07 * _input_rgb_color.b) < _threshold_color) ? 0.0 : 1.0);
}