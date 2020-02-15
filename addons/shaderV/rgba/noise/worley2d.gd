tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeNoiseWorley2d

func _init() -> void:
	set_input_port_default_value(1, Vector3(0, 0, 0))
	set_input_port_default_value(2, 5)
	set_input_port_default_value(3, 1)

func _get_name() -> String:
	return "WorleyNoise2D"

func _get_category() -> String:
	return "RGBA"

func _get_subcategory() -> String:
	return "Noise"

func _get_description() -> String:
	return "2d worley noise"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

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
			return "jitter"

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
	return 2

func _get_output_port_name(port: int):
	match port:
		0:
			return "F1"
		1:
			return "F2"

func _get_output_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_SCALAR
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_global_code(mode: int) -> String:
	return """
vec2 cellular2dNoiseFunc(vec2 P, float _jitter_w2d) {
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
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return """vec2 %s%s = cellular2dNoiseFunc((%s.xy+%s.xy)*%s, min(max(%s, 0.0), 1.0));
%s = %s%s.x;
%s = %s%s.y;""" % [
output_vars[0], output_vars[1], input_vars[0], input_vars[1], input_vars[2], input_vars[3],
output_vars[0], output_vars[0], output_vars[1],
output_vars[1], output_vars[0], output_vars[1]]
