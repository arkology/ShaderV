highp float _randImproved(vec2 _co_rnd){
	highp float _tmp_a_rnd = 12.9898;
	highp float _tmp_b_rnd = 78.233;
	highp float _tmp_c_rnd = 43758.5453;
	highp float _tmp_dt_rnd = dot(_co_rnd, vec2(_tmp_a_rnd, _tmp_b_rnd));
	highp float _tmp_sn_rnd = mod(_tmp_dt_rnd, 3.14);
	return fract(sin(_tmp_sn_rnd) * _tmp_c_rnd);
}