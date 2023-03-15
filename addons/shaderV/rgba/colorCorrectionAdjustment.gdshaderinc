vec3 _applyColorCorrectionFunc(vec3 _col_corr, sampler2D _tex_corr) {
	_col_corr.r = texture(_tex_corr, vec2(_col_corr.r, 0.0)).r;
	_col_corr.g = texture(_tex_corr, vec2(_col_corr.g, 0.0)).g;
	_col_corr.b = texture(_tex_corr, vec2(_col_corr.b, 0.0)).b;
	return _col_corr;
}