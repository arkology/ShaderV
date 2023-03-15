vec4 _chromaticAberrationFunc(sampler2D _texture_chr_aberration, vec2 _uv_chr_aberration, vec3 _values_chr_aberration){
	vec4 _col_chr_aberration = vec4(0.0);
	if (_values_chr_aberration.z < 0.0){
		_col_chr_aberration.r = texture(_texture_chr_aberration, _uv_chr_aberration + _values_chr_aberration.xy).r;
		_col_chr_aberration.g = texture(_texture_chr_aberration, _uv_chr_aberration).g;
		_col_chr_aberration.b = texture(_texture_chr_aberration, _uv_chr_aberration - _values_chr_aberration.xy).b;
		_col_chr_aberration.a = texture(_texture_chr_aberration, _uv_chr_aberration).a;
	}else{
		_col_chr_aberration.r = textureLod(_texture_chr_aberration, _uv_chr_aberration +
											_values_chr_aberration.xy, _values_chr_aberration.z).r;
		_col_chr_aberration.g = textureLod(_texture_chr_aberration, _uv_chr_aberration, _values_chr_aberration.z).g;
		_col_chr_aberration.b = textureLod(_texture_chr_aberration, _uv_chr_aberration -
											_values_chr_aberration.xy, _values_chr_aberration.z).b;
		_col_chr_aberration.a = textureLod(_texture_chr_aberration, _uv_chr_aberration, _values_chr_aberration.z).a;
	}
	return _col_chr_aberration;
}