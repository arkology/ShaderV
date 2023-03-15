vec4 _bloomFunc(vec4 _col_bloom, float _strength_bloom){
	float _gamma_bloom = 1.0 - pow(_col_bloom.r, _strength_bloom);
	_col_bloom.rgb += (_col_bloom.rgb * _col_bloom.a) * _strength_bloom;
	return _col_bloom;
}