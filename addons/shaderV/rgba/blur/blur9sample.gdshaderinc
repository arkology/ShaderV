vec4 _blur9sampleFunc(sampler2D _blur9sample_sample, vec2 _blur9sample_uv, float _blur9sample_lod, float _blur9sample_radius){
	vec4 _c01r_b1ur = vec4(0.0);
	if (_blur9sample_lod < 0.0){
		_c01r_b1ur = texture(_blur9sample_sample, _blur9sample_uv);
		_c01r_b1ur += texture(_blur9sample_sample, _blur9sample_uv + vec2(0, - _blur9sample_radius) * 0.01);
		_c01r_b1ur += texture(_blur9sample_sample, _blur9sample_uv + vec2(0, _blur9sample_radius) * 0.01);
		_c01r_b1ur += texture(_blur9sample_sample, _blur9sample_uv + vec2(- _blur9sample_radius, 0) * 0.01);
		_c01r_b1ur += texture(_blur9sample_sample, _blur9sample_uv + vec2(_blur9sample_radius, 0) * 0.01);
		_c01r_b1ur += texture(_blur9sample_sample, _blur9sample_uv + vec2(- _blur9sample_radius, - _blur9sample_radius) * 0.01);
		_c01r_b1ur += texture(_blur9sample_sample, _blur9sample_uv + vec2(- _blur9sample_radius, _blur9sample_radius) * 0.01);
		_c01r_b1ur += texture(_blur9sample_sample, _blur9sample_uv + vec2(_blur9sample_radius, _blur9sample_radius) * 0.01);
		_c01r_b1ur += texture(_blur9sample_sample, _blur9sample_uv + vec2(_blur9sample_radius, -_blur9sample_radius) * 0.01);
	}else{
		_c01r_b1ur = textureLod(_blur9sample_sample, _blur9sample_uv, _blur9sample_lod);
		_c01r_b1ur += textureLod(_blur9sample_sample, _blur9sample_uv + vec2(0, - _blur9sample_radius) * 0.01, _blur9sample_lod);
		_c01r_b1ur += textureLod(_blur9sample_sample, _blur9sample_uv + vec2(0, _blur9sample_radius) * 0.01, _blur9sample_lod);
		_c01r_b1ur += textureLod(_blur9sample_sample, _blur9sample_uv + vec2(- _blur9sample_radius, 0) * 0.01, _blur9sample_lod);
		_c01r_b1ur += textureLod(_blur9sample_sample, _blur9sample_uv + vec2(_blur9sample_radius, 0) * 0.01, _blur9sample_lod);
		_c01r_b1ur += textureLod(_blur9sample_sample, _blur9sample_uv + vec2(- _blur9sample_radius, - _blur9sample_radius) * 0.01, _blur9sample_lod);
		_c01r_b1ur += textureLod(_blur9sample_sample, _blur9sample_uv + vec2(- _blur9sample_radius, _blur9sample_radius) * 0.01, _blur9sample_lod);
		_c01r_b1ur += textureLod(_blur9sample_sample, _blur9sample_uv + vec2(_blur9sample_radius, _blur9sample_radius) * 0.01, _blur9sample_lod);
		_c01r_b1ur += textureLod(_blur9sample_sample, _blur9sample_uv + vec2(_blur9sample_radius, -_blur9sample_radius) * 0.01, _blur9sample_lod);
	}
	_c01r_b1ur /= 9.0;
	return _c01r_b1ur;
}