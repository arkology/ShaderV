vec3 _remapFunc(vec3 _remap_input, vec2 _remap_from, vec2 _remap_to){
	return _remap_to.x + ((_remap_input - _remap_from.x) * (_remap_to.y - _remap_to.x)) / (_remap_from.y - _remap_from.x);
}