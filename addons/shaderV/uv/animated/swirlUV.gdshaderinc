vec2 _swirlUVFunc(vec2 _swirl_uv, float _swirl_time, vec2 _swirl_pivot, float _swirl_amount){
	float _swirl_rotation_index = _swirl_amount * length(_swirl_uv - _swirl_pivot) * _swirl_time;
	_swirl_uv -= _swirl_pivot;
	_swirl_uv *= mat2(vec2(cos(_swirl_rotation_index), - sin(_swirl_rotation_index)),
										vec2(sin(_swirl_rotation_index), cos(_swirl_rotation_index)));
	_swirl_uv += _swirl_pivot;
	return _swirl_uv;
}