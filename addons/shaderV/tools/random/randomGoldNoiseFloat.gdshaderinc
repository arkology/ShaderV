float _randomGoldRatioFunc(vec2 _coord_gn, vec2 _scale_gn, float _seed_gn){
	float PHI = 1.6180339887; 
	float SQ2 = 1.4142135624;
	return fract(tan(distance((_coord_gn + _scale_gn) * (_seed_gn + PHI), vec2(PHI, PI))) * SQ2);
}