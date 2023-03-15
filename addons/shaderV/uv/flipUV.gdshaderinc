vec2 _flipUV(vec2 _flip_uv, vec2 _flip_vect) {
	_flip_uv.x = mix(_flip_uv.x, 1.0 - _flip_uv.x, _flip_vect.x);
	_flip_uv.y = mix(_flip_uv.y, 1.0 - _flip_uv.y, _flip_vect.y);
	return _flip_uv;
}