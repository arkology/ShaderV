tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeNoiseSimplex3dFractal

func _init() -> void:
	set_input_port_default_value(1, 6)
	set_input_port_default_value(2, Vector3(2, 2, 0))
	set_input_port_default_value(3, 2)
	set_input_port_default_value(4, 0.8)
	set_input_port_default_value(5, 0.5)
	set_input_port_default_value(6, 0.6)
	set_input_port_default_value(7, Vector3(0.5, 0.5, 0))
	set_input_port_default_value(8, 0)

func _get_name() -> String:
	return "FractalSimplexNoise3D"

func _get_category() -> String:
	return "RGBA"

func _get_subcategory() -> String:
	return "NoiseFractal"

func _get_description() -> String:
	return "Fractal 3D Simplex Noise"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_input_port_count() -> int:
	return 9

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
		8:
			return "time"

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
		8:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "result"

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_global_code(mode: int) -> String:
	return """
vec4 _permute_simplex3_n0ise_fractal(vec4 x) {
	return ((x * 34.0) + 1.0) * x - floor(((x * 34.0) + 1.0) * x * (1.0 / 289.0)) * 289.0;
}
float simplex3dN0iseFractalFunc(vec3 v) { 
	vec2 C = vec2(1.0/6.0, 1.0/3.0) ;
	vec4 D = vec4(0.0, 0.5, 1.0, 2.0);
	
	vec3 i  = floor(v + dot(v, vec3(C.y)));
	vec3 x0 = v - i + dot(i, vec3(C.x)) ;
	
	vec3 g = step(x0.yzx, x0.xyz);
	vec3 l = 1.0 - g;
	vec3 i1 = min( g.xyz, l.zxy );
	vec3 i2 = max( g.xyz, l.zxy );
	
	vec3 x1 = x0 - i1 + vec3(C.x);
	vec3 x2 = x0 - i2 + vec3(C.y);
	vec3 x3 = x0 - D.yyy;
	
	i = i - floor(i * (1.0 / 289.0)) * 289.0;
	vec4 p = _permute_simplex3_n0ise_fractal(_permute_simplex3_n0ise_fractal(_permute_simplex3_n0ise_fractal(
	 		i.z + vec4(0.0, i1.z, i2.z, 1.0))
		+   i.y + vec4(0.0, i1.y, i2.y, 1.0))
		+   i.x + vec4(0.0, i1.x, i2.x, 1.0));
	
	float n_ = 0.142857142857;
	vec3  ns = n_ * D.wyz - D.xzx;
	
	vec4 j = p - 49.0 * floor(p * ns.z * ns.z);
	
	vec4 x_ = floor(j * ns.z);
	vec4 y_ = floor(j - 7.0 * x_ );
	
	vec4 x = x_ *ns.x + vec4(ns.y);
	vec4 y = y_ *ns.x + vec4(ns.y);
	vec4 h = 1.0 - abs(x) - abs(y);
	
	vec4 b0 = vec4( x.xy, y.xy );
	vec4 b1 = vec4( x.zw, y.zw );
	
	vec4 s0 = floor(b0)*2.0 + 1.0;
	vec4 s1 = floor(b1)*2.0 + 1.0;
	vec4 sh = -step(h, vec4(0.0));
	
	vec4 a0 = b0.xzyw + s0.xzyw*sh.xxyy ;
	vec4 a1 = b1.xzyw + s1.xzyw*sh.zzww ;
	
	vec3 p0 = vec3(a0.xy,h.x);
	vec3 p1 = vec3(a0.zw,h.y);
	vec3 p2 = vec3(a1.xy,h.z);
	vec3 p3 = vec3(a1.zw,h.w);
	
	vec4 norm = 2.79284291400159 - 0.85373472095314 * vec4(dot(p0,p0), dot(p1,p1), dot(p2, p2), dot(p3,p3));
	p0 *= norm.x;
	p1 *= norm.y;
	p2 *= norm.z;
	p3 *= norm.w;
	
	vec4 m = max(0.6 - vec4(dot(x0,x0), dot(x1,x1), dot(x2,x2), dot(x3,x3)), vec4(0.0));
	m = m * m;
	return 22.0 * dot( m*m, vec4( dot(p0,x0), dot(p1,x1), dot(p2,x2), dot(p3,x3) ) );
}
float simplexNoise3DFBM(vec2 _uv_sn3fbm, int _oct_sn3fbm, vec2 _per_sn3fbm, float _lac_sn3fbm,
		float _persist_sn3fbm, float _rot_sn3fbm, float _ampl_sn3fbm, vec2 _shift_sn3fbm, float _time_sn3fbm) {
	float _v = 0.0;
	float _a = _ampl_sn3fbm;
	mat2 _r0t = mat2(vec2(cos(_rot_sn3fbm), sin(_rot_sn3fbm)), vec2(-sin(_rot_sn3fbm), cos(_rot_sn3fbm)));
	for (int i = 0; i < _oct_sn3fbm; ++i) {
		_v += _a * simplex3dN0iseFractalFunc(vec3(_uv_sn3fbm * _per_sn3fbm, _time_sn3fbm));
		_uv_sn3fbm = _r0t * _uv_sn3fbm * _lac_sn3fbm + _shift_sn3fbm;
		_a *= _persist_sn3fbm;
	}
	return (min(_v, 1.0) + 1.0) * 0.5;
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s = simplexNoise3DFBM(%s.xy, int(%s), %s.xy, %s, %s, %s, %s, %s.xy, %s);" % [
	output_vars[0], input_vars[0], input_vars[1], input_vars[2], input_vars[3],
	input_vars[4], input_vars[5], input_vars[6], input_vars[7], input_vars[8]]
