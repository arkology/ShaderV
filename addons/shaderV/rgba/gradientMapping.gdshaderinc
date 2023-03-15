vec4 _gradientMappingFunc(vec3 _col_base_gm, float _grad_offset, sampler2D _palette_gm, bool _use_col_cycle){
	float avg_col = 0.2126 * _col_base_gm.r + 0.7152 * _col_base_gm.g + 0.0722 * _col_base_gm.b;
	if (_use_col_cycle){
		return texture(_palette_gm, mod(vec2(avg_col + _grad_offset, 0), vec2(1.0)));
	} else{
		return texture(_palette_gm, vec2(avg_col + _grad_offset, 0));
	}
}