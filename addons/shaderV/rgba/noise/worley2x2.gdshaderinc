float _cellular2x2NoiseFunc(vec2 P, float _jitter_w2x2) {
	float K = 0.142857142857; // 1/7
	float K2 = 0.0714285714285; // K/2
	
	vec2 Pi = floor(P) - floor(floor(P) * (1.0 / 289.0)) * 289.0;
	vec2 Pf = fract(P);
	vec4 Pfx = Pf.x + vec4(-0.5, -1.5, -0.5, -1.5);
	vec4 Pfy = Pf.y + vec4(-0.5, -0.5, -1.5, -1.5);
	vec4 p = ((34.0*(Pi.x + vec4(0.0, 1.0, 0.0, 1.0))+1.0)*(Pi.x + vec4(0.0, 1.0, 0.0, 1.0)))-floor(((34.0*(Pi.x + vec4(0.0, 1.0, 0.0, 1.0))+1.0)*(Pi.x + vec4(0.0, 1.0, 0.0, 1.0)))*(1.0/289.0))*289.0;
	p = ((34.0*(p + Pi.y + vec4(0.0, 0.0, 1.0, 1.0))+1.0)*(p + Pi.y + vec4(0.0, 0.0, 1.0, 1.0)))-floor(((34.0*(p + Pi.y + vec4(0.0, 0.0, 1.0, 1.0))+1.0)*(p + Pi.y + vec4(0.0, 0.0, 1.0, 1.0)))*(1.0/289.0))*289.0;
	vec4 ox = (p - floor(p * (1.0 / 7.0)) * 7.0)*K+K2;
	vec4 oy = (floor(p*K) - floor(floor(p*K) * (1.0 / 7.0)) * 7.0)*K+K2;
	vec4 dx = Pfx + _jitter_w2x2*ox;
	vec4 dy = Pfy + _jitter_w2x2*oy;
	vec4 d = dx * dx + dy * dy;
	d.xy = min(d.xy, d.zw);
	d.x = min(d.x, d.y);
	return sqrt(d.x);
}