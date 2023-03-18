vec4 _generateCircle2Func(vec2 _uv_gc2, vec2 _pos_gc2, vec2 _scale_gc2, float _rad_gc2,
						 float _bordIn_gc2, float _bordOut_gc2, vec4 _col_gc2){
	float _dst_gc2 = length((_uv_gc2 - _pos_gc2) * _scale_gc2);
	_col_gc2.a *= smoothstep(_rad_gc2 - _bordIn_gc2, _rad_gc2, _dst_gc2) 
				 - smoothstep(_rad_gc2, _rad_gc2 + _bordOut_gc2, _dst_gc2);
	return _col_gc2;
}