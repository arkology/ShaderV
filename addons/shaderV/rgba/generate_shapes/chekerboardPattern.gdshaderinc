float _checkerboardPatternFunc(vec2 uv, vec2 _checker_size){
	float fmodRes = mod(floor(_checker_size.x * uv.x) + floor(_checker_size.y * uv.y), 2.0);
	return max(sign(fmodRes), 0.0);
}