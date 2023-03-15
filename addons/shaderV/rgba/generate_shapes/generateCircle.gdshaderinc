vec4 _generateCircleFunc(vec2 _uv_circle, vec2 _center_circle, vec2 _scale_factor_circle, float _innerRad_circle, float _outRad_circle, float _hard_circle) {
	float _innerRadiusCheck0 = min(_innerRad_circle, _outRad_circle);
	float _outerRadiusCheck0 = max(_innerRad_circle, _outRad_circle);
	
	float currentPositionCircle = length((_uv_circle - _center_circle) * _scale_factor_circle);
	float maxIntencityCenterCircle = (_outerRadiusCheck0 + _innerRadiusCheck0) * 0.5;
	float rd0 = _outerRadiusCheck0 - maxIntencityCenterCircle;
	float circleDistribution = min(max(abs(currentPositionCircle - maxIntencityCenterCircle) / rd0, 0.0), 1.0);
	vec4 _outputColor0 = vec4(1.0);
	_outputColor0.a = 1.0 - pow(circleDistribution, _hard_circle);
	return _outputColor0;
}