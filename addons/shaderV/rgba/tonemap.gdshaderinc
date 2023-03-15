vec3 _tonemapFunc(vec3 _color_tonemap, float _exposure_tonemap, float _gamma_tonemap){
	_color_tonemap.rgb *= pow(2.0, _exposure_tonemap);
	_color_tonemap.rgb = pow(_color_tonemap.rgb, vec3(_gamma_tonemap));
	return _color_tonemap;
}