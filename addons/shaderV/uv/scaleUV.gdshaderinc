vec2 _scaleUV(vec2 _scale_uv, vec2 _scale_vect, vec2 _pivot_vect) {
	return (_scale_uv - _pivot_vect) * _scale_vect + _pivot_vect;
}