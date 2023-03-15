vec2 _rotateUVAnimatedFunc(vec2 _uv_rotate, vec2 _pivot_rotate, float _rotation_rotate, float _rotSpeed_rotate, float _time_rotate){
	_rotation_rotate += _time_rotate * _rotSpeed_rotate;
	//_rotation_rotate = radians(_rotationDeg_rotate);
	vec2 _rotAngle = vec2(cos(_rotation_rotate), sin(_rotation_rotate));
	_uv_rotate -= _pivot_rotate;
	_uv_rotate = vec2((_uv_rotate.x*_rotAngle.x-_uv_rotate.y*_rotAngle.y),(_uv_rotate.x*_rotAngle.y+_uv_rotate.y*_rotAngle.x));
	_uv_rotate += _pivot_rotate;
	return _uv_rotate;
}