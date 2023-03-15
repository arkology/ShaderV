float _scanLinesSharpFunc(vec2 _uv_scLiShrp, float _amount_scLiShrp, float _fill_scLiShrp, float _spd_scLiShrp, float _time_scLiShrp) {
	return step(fract(_uv_scLiShrp.y * _amount_scLiShrp + _time_scLiShrp * _spd_scLiShrp), _fill_scLiShrp);
}