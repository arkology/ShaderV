vec4 _embossFunc(sampler2D _tex_emboss, vec2 _uv_emboss, float _lod_emboss, vec2 _ofst_emboss, float _ctst_emboss){
	vec4 col_emboss = vec4(0.5, 0.5, 0.5, 0.5);
	if (_lod_emboss < 0.0){
		col_emboss -= texture(_tex_emboss, _uv_emboss - _ofst_emboss) * _ctst_emboss;
		col_emboss += texture(_tex_emboss, _uv_emboss + _ofst_emboss) * _ctst_emboss;
	}else{
		col_emboss -= textureLod(_tex_emboss, _uv_emboss - _ofst_emboss, _lod_emboss) * _ctst_emboss;
		col_emboss += textureLod(_tex_emboss, _uv_emboss + _ofst_emboss, _lod_emboss) * _ctst_emboss;
	}
	col_emboss.rgb = vec3(0.21 * col_emboss.r + 0.71 * col_emboss.g + 0.07 * col_emboss.b);
	return col_emboss;
}