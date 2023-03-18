vec3 _cg4PaletteFunc(vec3 _col_cga, float _gamma_cga){
	_col_cga = pow(_col_cga, vec3(_gamma_cga));
	float _gray_col_cga4 = 0.21 * _col_cga.r + 0.71 * _col_cga.g + 0.07 * _col_cga.b;
	vec3 _res_col_cga4 = vec3(0.0);
	
	if      (_gray_col_cga4 <= 1.0/4.0)
		_res_col_cga4 = vec3(0.0,  0.0,  0.0);
	else if (_gray_col_cga4 <= 2.0/4.0)
		_res_col_cga4 = vec3(1.0,  0.33, 1.0);
	else if (_gray_col_cga4 <= 3.0/4.0)
		_res_col_cga4 = vec3(0.33, 1.0,  1.0);
	else if (_gray_col_cga4 <= 4.0/4.0)
		_res_col_cga4 = vec3(1.0,  1.0,  1.0);
	
	return _res_col_cga4;
}