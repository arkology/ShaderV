vec3 _twirlUVFunc(vec2 _uv_twirlUVFunc, vec2 _pivot_twirlUVFunc, float _amount_twirlUVFunc){
	_uv_twirlUVFunc -= _pivot_twirlUVFunc;
	float _angle_twirlUVFunc = atan(_uv_twirlUVFunc.y, _uv_twirlUVFunc.x);
	float _radiusTemp_twirlUVFunc = length(_uv_twirlUVFunc);
	_angle_twirlUVFunc += _radiusTemp_twirlUVFunc * _amount_twirlUVFunc;
	return vec3(_radiusTemp_twirlUVFunc * vec2(cos(_angle_twirlUVFunc), sin(_angle_twirlUVFunc)) + 0.5, 0.0);
}