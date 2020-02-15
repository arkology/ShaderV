tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeNoiseSimplex4d

func _init() -> void:
	set_input_port_default_value(1, Vector3(0, 0, 0))
	set_input_port_default_value(2, 5)
	set_input_port_default_value(3, 1)
	set_input_port_default_value(4, 0)

func _get_name() -> String:
	return "SimplexNoise4D"

func _get_category() -> String:
	return "RGBA"

func _get_subcategory() -> String:
	return "Noise"

func _get_description() -> String:
	return "4d simplex noise"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_input_port_count() -> int:
	return 5

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "offset"
		2:
			return "scale"
		3:
			return "z"
		4:
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
		4:
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
vec4 _permute_4_s4_n0ise(vec4 x) {
	return ((x * 34.0) + 1.0) * x - floor(((x * 34.0) + 1.0) * x * (1.0 / 289.0)) * 289.0;
}
float _permute_s4_n0ise(float x) {
	return ((x * 34.0) + 1.0) * x - floor(((x * 34.0) + 1.0) * x * (1.0 / 289.0)) * 289.0;
}
vec4 _grad4_s4_n0ise(float j, vec4 ip) {
	vec4 ones = vec4(1.0, 1.0, 1.0, -1.0);
	vec4 p, s;
	p.xyz = floor( fract (vec3(j) * ip.xyz) * 7.0) * ip.z - 1.0;
	p.w = 1.5 - dot(abs(p.xyz), ones.xyz);
	s = vec4(lessThan(p, vec4(0.0)));
	p.xyz = p.xyz + (s.xyz*2.0 - 1.0) * s.www; 
	return p;
}
float simplex4dN0iseFunc(vec4 v) {
	vec4 C = vec4( 0.138196601125011,
				0.276393202250021,
				0.414589803375032,
				-0.447213595499958);
	
	vec4 i  = floor(v + dot(v, vec4(0.309016994374947451)) );
	vec4 x0 = v -   i + dot(i, C.xxxx);
	
	vec4 i0;
	vec3 isX = step( x0.yzw, x0.xxx );
	vec3 isYZ = step( x0.zww, x0.yyz );
	i0.x = isX.x + isX.y + isX.z;
	i0.yzw = 1.0 - isX;
	i0.y += isYZ.x + isYZ.y;
	i0.zw += 1.0 - isYZ.xy;
	i0.z += isYZ.z;
	i0.w += 1.0 - isYZ.z;
	
	vec4 i3 = clamp( i0, 0.0, 1.0 );
	vec4 i2 = clamp( i0-1.0, 0.0, 1.0 );
	vec4 i1 = clamp( i0-2.0, 0.0, 1.0 );
	
	vec4 x1 = x0 - i1 + C.xxxx;
	vec4 x2 = x0 - i2 + C.yyyy;
	vec4 x3 = x0 - i3 + C.zzzz;
	vec4 x4 = x0 + C.wwww;
	
	i = i - floor(i * (1.0 / 289.0)) * 289.0;
	float j0 = _permute_s4_n0ise( _permute_s4_n0ise( _permute_s4_n0ise( _permute_s4_n0ise(i.w) + i.z) + i.y) + i.x);
	vec4 j1 = _permute_4_s4_n0ise( _permute_4_s4_n0ise( _permute_4_s4_n0ise( _permute_4_s4_n0ise (
				i.w + vec4(i1.w, i2.w, i3.w, 1.0 ))
				+ i.z + vec4(i1.z, i2.z, i3.z, 1.0 ))
				+ i.y + vec4(i1.y, i2.y, i3.y, 1.0 ))
				+ i.x + vec4(i1.x, i2.x, i3.x, 1.0 ));
	
	vec4 ip = vec4(1.0/294.0, 1.0/49.0, 1.0/7.0, 0.0) ;
	
	vec4 p0 = _grad4_s4_n0ise(j0,   ip);
	vec4 p1 = _grad4_s4_n0ise(j1.x, ip);
	vec4 p2 = _grad4_s4_n0ise(j1.y, ip);
	vec4 p3 = _grad4_s4_n0ise(j1.z, ip);
	vec4 p4 = _grad4_s4_n0ise(j1.w, ip);
	
	vec4 norm = 2.79284291400159 - 1.85373472095314 * vec4(dot(p0,p0), dot(p1,p1), dot(p2, p2), dot(p3,p3));
	p0 *= norm.x;
	p1 *= norm.y;
	p2 *= norm.z;
	p3 *= norm.w;
	p4 *= 2.79284291400159 - 1.85373472095314 * dot(p4,p4);
	
	vec3 m0 = max(0.6 - vec3(dot(x0,x0), dot(x1,x1), dot(x2,x2)), vec3(0.0));
	vec2 m1 = max(0.6 - vec2(dot(x3,x3), dot(x4,x4)), vec2(0.0));
	m0 = m0 * m0;
	m1 = m1 * m1;
	return 33.0 *(dot(m0*m0, vec3(dot(p0, x0), dot(p1, x1), dot(p2, x2)))
				+ dot(m1*m1, vec2(dot(p3, x3), dot(p4, x4))));
}
"""
func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s = simplex4dN0iseFunc(vec4((%s.xy + %s.xy) * %s, %s, %s));" % [
output_vars[0], input_vars[0], input_vars[1], input_vars[2], input_vars[3], input_vars[4]]
