float _perlin2dNoiseFuncFractal(vec2 P) {
	vec4 Pi = floor(vec4(P, P)) + vec4(0.0, 0.0, 1.0, 1.0);
	vec4 Pf = fract(vec4(P, P)) - vec4(0.0, 0.0, 1.0, 1.0);
	
	Pi = Pi - floor(Pi * (1.0 / 289.0)) * 289.0;
	vec4 ix = Pi.xzxz;
	vec4 iy = Pi.yyww;
	vec4 fx = Pf.xzxz;
	vec4 fy = Pf.yyww;
	
	vec4 i = (((((((ix*34.0)+1.0)*ix)-floor((((ix*34.0)+1.0)*ix)*(1.0/289.0))*289.0 + iy)*34.0)+1.0)*
		((((ix*34.0)+1.0)*ix)-floor((((ix*34.0)+1.0)*ix)*(1.0/289.0))*289.0 + iy))-
		floor((((((((ix*34.0)+1.0)*ix)-floor((((ix*34.0)+1.0)*ix)*(1.0/289.0))*289.0 + iy)*34.0)+1.0)*
		((((ix*34.0)+1.0)*ix)-floor((((ix*34.0)+1.0)*ix)*(1.0/289.0))*289.0 + iy))*(1.0/289.0))*289.0;
	
	vec4 gx = fract(i * (1.0 / 41.0)) * 2.0 - 1.0 ;
	vec4 gy = abs(gx) - 0.5 ;
	vec4 tx = floor(gx + 0.5);
	gx = gx - tx;
	
	vec2 g00 = vec2(gx.x,gy.x);
	vec2 g10 = vec2(gx.y,gy.y);
	vec2 g01 = vec2(gx.z,gy.z);
	vec2 g11 = vec2(gx.w,gy.w);
	
	vec4 norm = 1.79284291400159 - 0.85373472095314 * vec4(dot(g00, g00), dot(g01, g01), dot(g10, g10), dot(g11, g11));
	g00 *= norm.x;
	g01 *= norm.y;
	g10 *= norm.z;
	g11 *= norm.w;
	
	float n00 = dot(g00, vec2(fx.x, fy.x));
	float n10 = dot(g10, vec2(fx.y, fy.y));
	float n01 = dot(g01, vec2(fx.z, fy.z));
	float n11 = dot(g11, vec2(fx.w, fy.w));
	
	vec2 fade_xy = Pf.xy * Pf.xy * Pf.xy * (Pf.xy * (Pf.xy * 6.0 - 15.0) + 10.0);
	vec2 n_x = mix(vec2(n00, n01), vec2(n10, n11), fade_xy.x);
	float n_xy = mix(n_x.x, n_x.y, fade_xy.y);
	return 2.3 * n_xy;
}
float _perlinNoise2DFBM(vec2 _uv_pn2fbm, int _oct_pn2fbm, vec2 _per_pn2fbm, float _lac_pn2fbm,
						float _persist_pn2fbm, float _rot_pn2fbm, float _ampl_pn2fbm, vec2 _shift_pn2fbm) {
	float _v = 0.0;
	float _a = _ampl_pn2fbm;
	mat2 _r0t = mat2(vec2(cos(_rot_pn2fbm), sin(_rot_pn2fbm)), vec2(-sin(_rot_pn2fbm), cos(_rot_pn2fbm)));
	for (int i = 0; i < _oct_pn2fbm; ++i) {
		_v += _a * _perlin2dNoiseFuncFractal(_uv_pn2fbm * _per_pn2fbm);
		_uv_pn2fbm = _r0t * _uv_pn2fbm * _lac_pn2fbm + _shift_pn2fbm;
		_a *= _persist_pn2fbm;
	}
	return (min(_v, 1.0) + 1.0) * 0.5;
}