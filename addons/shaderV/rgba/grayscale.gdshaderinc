vec3 _grayscaleFunc(vec3 _color_grayscale, float _gray_factor){
	return _color_grayscale * (1.0 - _gray_factor) + (0.21 * _color_grayscale.r + 0.71 * _color_grayscale.g + 0.07 * _color_grayscale.b) * _gray_factor;
}