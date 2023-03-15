vec4 _generateSpiralFunc(vec2 _uv_genSpir, vec2 _pivot_genSpir, float _size_genSpir, float _lineAmnt_genSpir,
						float _spd_genSpir, float _soft_genSpir, float _t1me_genSpir, vec4 _col_genSpir){
	_uv_genSpir -= _pivot_genSpir;
	float _va1ue_genSpir = 1.0 - sin(length(_uv_genSpir) * _size_genSpir +
					floor(_lineAmnt_genSpir) * atan(_uv_genSpir.x, _uv_genSpir.y) +
					_t1me_genSpir * _spd_genSpir ) / _soft_genSpir;
	return vec4(_col_genSpir.rgb, _col_genSpir.a * _va1ue_genSpir);
}