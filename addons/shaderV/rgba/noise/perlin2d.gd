tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeNoisePerlin2d

func _init() -> void:
	set_input_port_default_value(1, Vector3(0, 0, 0))
	set_input_port_default_value(2, 5)
	set_input_port_default_value(3, Vector3(0.0, 0.0, 0.0))

func _get_name() -> String:
	return "PerlinNoise2D"

func _get_category() -> String:
	return "RGBA"

func _get_subcategory() -> String:
	return "Noise"

func _get_description() -> String:
	return """Classic 2d perlin noise with ability to set period.
If you dont want any peroid - set it to zero"""

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
			return "period"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR
		3:
			return VisualShaderNode.PORT_TYPE_VECTOR

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
float perlin2dN0iseFunc(vec2 P, vec2 _per10d_perl2) {
	vec4 Pi = floor(vec4(P, P)) + vec4(0.0, 0.0, 1.0, 1.0);
	vec4 Pf = fract(vec4(P, P)) - vec4(0.0, 0.0, 1.0, 1.0);
	
	if (_per10d_perl2.x != 0.0 && _per10d_perl2.y != 0.0)
		Pi = mod(Pi, vec4(_per10d_perl2, _per10d_perl2));
	
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
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s = perlin2dN0iseFunc((%s.xy+%s.xy)*%s, %s.xy);" % [
output_vars[0], input_vars[0], input_vars[1], input_vars[2], input_vars[3]]
