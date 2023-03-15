vec3 _gameboyPaletteFunc(vec3 _col_gbp0, float _gamma_gbp0){
	_col_gbp0 = pow(_col_gbp0, vec3(_gamma_gbp0));
	float _gray_col_gbp0 = 0.21 * _col_gbp0.r + 0.71 * _col_gbp0.g + 0.07 * _col_gbp0.b;
	vec3 _res_col_gbp0 = vec3(0.0);
	
	if      (_gray_col_gbp0 <= 1.0/4.0)
		_res_col_gbp0 = vec3(0.063, 0.247, 0.063);
	else if (_gray_col_gbp0 <= 2.0/4.0)
		_res_col_gbp0 = vec3(0.188, 0.392, 0.188);
	else if (_gray_col_gbp0 <= 3.0/4.0)
		_res_col_gbp0 = vec3(0.549, 0.667, 0.078);
	else if (_gray_col_gbp0 <= 4.0/4.0)
		_res_col_gbp0 = vec3(0.612, 0.725, 0.086);
	
	return _res_col_gbp0;
}