tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeNoiseSimplex3d

func _init() -> void:
	set_input_port_default_value(1, Vector3(0, 0, 0))
	set_input_port_default_value(2, 5)
	set_input_port_default_value(3, 0)

func _get_name() -> String:
	return "SimplexNoise3D"

func _get_category() -> String:
	return "RGBA"

func _get_subcategory() -> String:
	return "Noise"

func _get_description() -> String:
	return "3d simplex noise"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_input_port_count() -> int:
	return 4

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "offset"
		2:
			return "scale"
		3:
			return "time"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR
		3:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int):
	match port:
		0:
			return "result"

func _get_output_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_global_code(mode: int) -> String:
	return """
vec4 _permute_simplex3_n0ise(vec4 x) {
	return ((x * 34.0) + 1.0) * x - floor(((x * 34.0) + 1.0) * x * (1.0 / 289.0)) * 289.0;
}
float simplex3dN0iseFunc(vec3 v) { 
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
	vec4 p = _permute_simplex3_n0ise(_permute_simplex3_n0ise(_permute_simplex3_n0ise(
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
"""
func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s = simplex3dN0iseFunc(vec3((%s.xy + %s.xy) * %s, %s));" % [
output_vars[0], input_vars[0], input_vars[1], input_vars[2], input_vars[3]]
