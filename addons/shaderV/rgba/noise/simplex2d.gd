tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeNoiseSimplex2d

func _init() -> void:
	set_input_port_default_value(1, Vector3(0, 0, 0))
	set_input_port_default_value(2, 5)

func _get_name() -> String:
	return "SimplexNoise2D"

func _get_category() -> String:
	return "RGBA"

func _get_subcategory() -> String:
	return "Noise"

func _get_description() -> String:
	return "2d simplex noise"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_input_port_count() -> int:
	return 3

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "offset"
		2:
			return "scale"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR
		2:
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
vec3 _permute_simplex2_n0ise(vec3 x) {
	return ((x*34.0)+1.0)*x-floor(((x*34.0)+1.0)*x*(1.0/289.0))*289.0;
}

float simplex2dN0iseFunc(vec2 v) {
	vec4 C = vec4(0.211324865405187,
				0.366025403784439,
				-0.577350269189626,
				0.024390243902439);
	
	vec2 i  = floor(v + dot(v, C.yy) );
	vec2 x0 = v -   i + dot(i, C.xx);
	
	vec2 i1;
	i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
	vec4 x12 = vec4(x0.xy, x0.xy) + C.xxzz;
	x12.xy -= i1;
	
	i = i - floor(i * (1.0 / 289.0)) * 289.0;
	vec3 p = _permute_simplex2_n0ise(_permute_simplex2_n0ise(i.y + vec3(0.0, i1.y, 1.0 )) + i.x + vec3(0.0, i1.x, 1.0));
	
	vec3 m = max(0.5 - vec3(dot(x0, x0), dot(x12.xy, x12.xy), dot(x12.zw, x12.zw)), vec3(0.0));
	m = m * m;
	m = m * m;
	
	vec3 x = 2.0 * fract(p * C.www) - 1.0;
	vec3 h = abs(x) - 0.5;
	vec3 ox = floor(x + 0.5);
	vec3 a0 = x - ox;
	
	m *= 1.79284291400159 - 0.85373472095314 * (a0 * a0 + h * h);
	
	vec3 g;
	g.x  = a0.x  * x0.x  + h.x  * x0.y;
	g.yz = a0.yz * x12.xz + h.yz * x12.yw;
	return 130.0 * dot(m, g);
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s = simplex2dN0iseFunc((%s.xy+%s.xy)*%s);" % [
output_vars[0], input_vars[0], input_vars[1], input_vars[2]]
