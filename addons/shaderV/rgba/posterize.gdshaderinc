vec3 _posterizeFunc(vec3 _col_posterize, float _steps_posterize){
	return floor(_col_posterize * _steps_posterize) / (_steps_posterize - 1.0);
}