vec4 _maskAlphaFunc(vec4 _col_to_mask, float _mask_alpha_to_mask){
	return vec4(_col_to_mask.rgb, _col_to_mask.a * _mask_alpha_to_mask);
}