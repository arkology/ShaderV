vec2 _distortionUVAnimatedFunc(vec2 _uv_dist, float _distX_dist, float _distY_dist, float _waveX_dist, float _waveY_dist, float _spd_dist, float _time_dist){
	_uv_dist.x += sin(_uv_dist.y * _waveX_dist + _time_dist * _spd_dist) * _distX_dist;
	_uv_dist.y += sin(_uv_dist.x * _waveY_dist + _time_dist * _spd_dist) * _distY_dist;
	return _uv_dist;
}