vec2 _cellular2dNoiseFunc(vec2 P, float _jitter_w2d) {
	float K = 0.142857142857; // 1/7
	float Ko = 0.428571428571; // 3/7
	
	vec2 Pi = floor(P) - floor(floor(P) * (1.0 / 289.0)) * 289.0;
	vec2 Pf = fract(P);
	vec3 oi = vec3(-1.0, 0.0, 1.0);
	vec3 of = vec3(-0.5, 0.5, 1.5);
	vec3 px = (34.0*(Pi.x+oi)+1.0)*(Pi.x+oi)-floor((34.0*(Pi.x+oi)+1.0)*(Pi.x+oi)*(1.0/289.0))* 289.0;
	vec3 p = (34.0*(px.x+Pi.y+ oi)+1.0)*(px.x+Pi.y+ oi)-floor((34.0*(px.x+Pi.y+oi)+1.0)*(px.x+Pi.y+ oi)*(1.0/289.0))*289.0;
	vec3 ox = fract(p*K) - Ko;
	vec3 oy = (floor(p*K) - floor(floor(p*K) * (1.0 / 7.0)) * 7.0) * K - Ko;
	vec3 dx = Pf.x + 0.5 + _jitter_w2d*ox;
	vec3 dy = Pf.y - of + _jitter_w2d*oy;
	vec3 d1 = dx * dx + dy * dy;
	p = (34.0*(px.y+Pi.y+oi)+1.0)*(px.y+Pi.y+oi)-floor((34.0*(px.y+Pi.y+oi)+1.0)*(px.y+Pi.y+oi)*(1.0/289.0))*289.0;
	ox = fract(p*K) - Ko;
	oy = (floor(p*K) - floor(floor(p*K) * (1.0 / 7.0)) * 7.0) * K - Ko;
	dx = Pf.x - 0.5 + _jitter_w2d*ox;
	dy = Pf.y - of + _jitter_w2d*oy;
	vec3 d2 = dx * dx + dy * dy;
	p = (34.0*(px.z+Pi.y+oi)+1.0)*(px.z+Pi.y+oi)-floor((34.0*(px.z+Pi.y+oi)+1.0)*(px.z+Pi.y+oi)*(1.0/289.0))*289.0;
	ox = fract(p*K) - Ko;
	oy = (floor(p*K) - floor(floor(p*K) * (1.0 / 7.0)) * 7.0) * K - Ko;
	dx = Pf.x - 1.5 + _jitter_w2d*ox;
	dy = Pf.y - of + _jitter_w2d*oy;
	vec3 d3 = dx * dx + dy * dy;
	vec3 d1a = min(d1, d2);
	d2 = max(d1, d2);
	d2 = min(d2, d3);
	d1 = min(d1a, d2);
	d2 = max(d1a, d2);
	d1.xy = (d1.x < d1.y) ? d1.xy : d1.yx;
	d1.xz = (d1.x < d1.z) ? d1.xz : d1.zx;
	d1.yz = min(d1.yz, d2.yz);
	d1.y = min(d1.y, d1.z);
	d1.y = min(d1.y, d2.x);
	return sqrt(d1.xy);
}