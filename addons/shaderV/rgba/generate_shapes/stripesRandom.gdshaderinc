float _generateRandomStripesFunc(vec2 _uv_stripes, float _fill_stripes, float _amount_stripes){
	return 1.0 - step(_fill_stripes, fract(sin(dot(floor(vec2(_uv_stripes.y) * _amount_stripes), vec2(12.9898, 78.233))) * 43758.5453123));
}