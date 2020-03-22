tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeNoisePerlin2dFractal

func _init() -> void:
	set_input_port_default_value(1, 6)
	set_input_port_default_value(2, Vector3(2, 2, 0))
	set_input_port_default_value(3, 2)
	set_input_port_default_value(4, 0.8)
	set_input_port_default_value(5, 0.5)
	set_input_port_default_value(6, 0.6)
	set_input_port_default_value(7, Vector3(0.5, 0.5, 0))

func _get_name() -> String:
	return "FractalPerlinNoise2D"

func _get_category() -> String:
	return "RGBA"

func _get_subcategory() -> String:
	return "NoiseFractal"

func _get_description() -> String:
	return "Fractal 2D Perlin Noise"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_input_port_count() -> int:
	return 8

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "octaves"
		2:
			return "period"
		3:
			return "lacunarity"
		4:
			return "persistence"
		5:
			return "angle"
		6:
			return "amplitude"
		7:
			return "shift"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
		2:
			return VisualShaderNode.PORT_TYPE_VECTOR
		3:
			return VisualShaderNode.PORT_TYPE_SCALAR
		4:
			return VisualShaderNode.PORT_TYPE_SCALAR
		5:
			return VisualShaderNode.PORT_TYPE_SCALAR
		6:
			return VisualShaderNode.PORT_TYPE_SCALAR
		7:
			return VisualShaderNode.PORT_TYPE_VECTOR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "result"

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_global_code(mode: int) -> String:
	return """
float perlin2dN0iseFuncFractal(vec2 P) {
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
float perlinNoise2DFBM(vec2 _uv_pn2fbm, int _oct_pn2fbm, vec2 _per_pn2fbm, float _lac_pn2fbm,
						float _persist_pn2fbm, float _rot_pn2fbm, float _ampl_pn2fbm, vec2 _shift_pn2fbm) {
	float _v = 0.0;
	float _a = _ampl_pn2fbm;
	mat2 _r0t = mat2(vec2(cos(_rot_pn2fbm), sin(_rot_pn2fbm)), vec2(-sin(_rot_pn2fbm), cos(_rot_pn2fbm)));
	for (int i = 0; i < _oct_pn2fbm; ++i) {
		_v += _a * perlin2dN0iseFuncFractal(_uv_pn2fbm * _per_pn2fbm);
		_uv_pn2fbm = _r0t * _uv_pn2fbm * _lac_pn2fbm + _shift_pn2fbm;
		_a *= _persist_pn2fbm;
	}
	return (min(_v, 1.0) + 1.0) * 0.5;
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s = perlinNoise2DFBM(%s.xy, int(%s), %s.xy, %s, %s, %s, %s, %s.xy);" % [
	output_vars[0], input_vars[0], input_vars[1], input_vars[2], input_vars[3],
	input_vars[4], input_vars[5], input_vars[6], input_vars[7]]
