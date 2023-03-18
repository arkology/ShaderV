vec3 _applyBCS(vec3 _input_rgb_color, vec3 _brighntess_contrast_saturation_vec) {
	_input_rgb_color = mix(vec3(0.0), _input_rgb_color, _brighntess_contrast_saturation_vec.x);
	_input_rgb_color = mix(vec3(0.5), _input_rgb_color, _brighntess_contrast_saturation_vec.y);
	_input_rgb_color = mix(vec3(dot(vec3(1.0), _input_rgb_color) * 0.33333), _input_rgb_color, _brighntess_contrast_saturation_vec.z);
	return _input_rgb_color;
}