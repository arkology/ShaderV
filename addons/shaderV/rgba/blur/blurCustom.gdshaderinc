vec4 _blurWithAmountFunc(sampler2D _tex_blur_cst, vec2 _uv_blur_cst, float _l0d_blur_cst, int _amnt_blur_cst, float _0ffst_blur_cst) {
	vec4 _c0l_blur_cst = vec4(0, 0, 0, 0);
	
	for(int x = -_amnt_blur_cst; x <= _amnt_blur_cst; x++) {
		for(int y = -_amnt_blur_cst; y <= _amnt_blur_cst; y++) {
			vec2 _c00rd_blur_cst = _uv_blur_cst + vec2(float(x), float(y)) * _0ffst_blur_cst;
			if (_l0d_blur_cst < 0.0){
				_c0l_blur_cst += texture(_tex_blur_cst, _c00rd_blur_cst);
			}else{
				_c0l_blur_cst += textureLod(_tex_blur_cst, _c00rd_blur_cst, _l0d_blur_cst);
			}
		}
	}
	int _nmb_ne1ghb0urs_blur_cst = (_amnt_blur_cst * 2 + 1) * (_amnt_blur_cst * 2 + 1);
	_c0l_blur_cst /= float(_nmb_ne1ghb0urs_blur_cst);
	return _c0l_blur_cst;
}