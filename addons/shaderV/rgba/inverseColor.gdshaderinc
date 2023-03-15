vec3 _inverseColorFunc(vec3 _color_to_inverse, float _inverse_color_intensity){
	return mix(_color_to_inverse.rgb, 1.0 - _color_to_inverse.rgb, _inverse_color_intensity);
}