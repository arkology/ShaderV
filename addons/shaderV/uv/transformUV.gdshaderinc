vec2 _transformUV(vec2 _uv_transform, vec2 _scale_uv_, vec2 _pivot_scale_uv_, vec2 _offset_uv_, float _rotate_uv, vec2 _pivot_rotate_uv_){
	_uv_transform -= _offset_uv_; // offset
	_uv_transform = (_uv_transform - _pivot_scale_uv_) * _scale_uv_ + _pivot_scale_uv_; // zoom
	vec2 _rot_uv_angl = vec2(cos(_rotate_uv), sin(_rotate_uv));
	mat2 _rot_matrix = mat2(vec2(_rot_uv_angl.x, - _rot_uv_angl.y), vec2(_rot_uv_angl.y, _rot_uv_angl.x));
	_uv_transform = (_uv_transform - _pivot_rotate_uv_) * _rot_matrix + _pivot_rotate_uv_; // rotate
	return _uv_transform;
}