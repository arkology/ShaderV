tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeNoisePerlin3d

func _init() -> void:
	set_input_port_default_value(1, Vector3(0, 0, 0))
	set_input_port_default_value(2, 5)
	set_input_port_default_value(3, 0)

func _get_name() -> String:
	return "PerlinNoise3D"

func _get_category() -> String:
	return "RGBA"

func _get_subcategory() -> String:
	return "Noise"

func _get_description() -> String:
	return "Classic 3d perlin noise"

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
float perlin3dNoiseFunc(vec3 P) {
	vec3 Pi0 = floor(P);
	vec3 Pi1 = Pi0 + vec3(1.0);
	Pi0 = Pi0 - floor(Pi0 * (1.0 / 289.0)) * 289.0;
	Pi1 = Pi1 - floor(Pi1 * (1.0 / 289.0)) * 289.0;
	vec3 Pf0 = fract(P);
	vec3 Pf1 = Pf0 - vec3(1.0);
	vec4 ix = vec4(Pi0.x, Pi1.x, Pi0.x, Pi1.x);
	vec4 iy = vec4(Pi0.yy, Pi1.yy);
	vec4 iz0 = vec4(Pi0.z);
	vec4 iz1 = vec4(Pi1.z);
	
	vec4 ixy = (((((((ix*34.0)+1.0)*ix)-floor(((ix*34.0)+1.0)*ix*(1.0/289.0))*289.0 + iy)*34.0)+1.0)*
		((((ix*34.0)+1.0)*ix)-floor(((ix*34.0)+1.0)*ix*(1.0/289.0))*289.0 + iy))-
		floor(((((((ix*34.0)+1.0)*ix)-floor(((ix*34.0)+1.0)*ix*(1.0/289.0))*289.0 + iy)*34.0)+1.0)*
		((((ix*34.0)+1.0)*ix)-floor(((ix*34.0)+1.0)*ix*(1.0/289.0))*289.0 + iy)*(1.0/289.0))*289.0;
	vec4 ixy0 = ((((ixy + iz0)*34.0)+1.0)*(ixy + iz0))-floor((((ixy + iz0)*34.0)+1.0)*(ixy + iz0)*(1.0/289.0))*289.0;
	vec4 ixy1 = ((((ixy + iz1)*34.0)+1.0)*(ixy + iz1))-floor((((ixy + iz1)*34.0)+1.0)*(ixy + iz1)*(1.0/289.0))*289.0;
	
	vec4 gx0 = ixy0 * (1.0 / 7.0);
	vec4 gy0 = fract(floor(gx0) * (1.0 / 7.0)) - 0.5;
	gx0 = fract(gx0);
	vec4 gz0 = vec4(0.5) - abs(gx0) - abs(gy0);
	vec4 sz0 = step(gz0, vec4(0.0));
	gx0 -= sz0 * (step(0.0, gx0) - 0.5);
	gy0 -= sz0 * (step(0.0, gy0) - 0.5);
	
	vec4 gx1 = ixy1 * (1.0 / 7.0);
	vec4 gy1 = fract(floor(gx1) * (1.0 / 7.0)) - 0.5;
	gx1 = fract(gx1);
	vec4 gz1 = vec4(0.5) - abs(gx1) - abs(gy1);
	vec4 sz1 = step(gz1, vec4(0.0));
	gx1 -= sz1 * (step(0.0, gx1) - 0.5);
	gy1 -= sz1 * (step(0.0, gy1) - 0.5);
	
	vec3 g000 = vec3(gx0.x,gy0.x,gz0.x);
	vec3 g100 = vec3(gx0.y,gy0.y,gz0.y);
	vec3 g010 = vec3(gx0.z,gy0.z,gz0.z);
	vec3 g110 = vec3(gx0.w,gy0.w,gz0.w);
	vec3 g001 = vec3(gx1.x,gy1.x,gz1.x);
	vec3 g101 = vec3(gx1.y,gy1.y,gz1.y);
	vec3 g011 = vec3(gx1.z,gy1.z,gz1.z);
	vec3 g111 = vec3(gx1.w,gy1.w,gz1.w);
	
	vec4 norm0 = 1.79284291400159 - 0.85373472095314 * vec4(dot(g000, g000), dot(g010, g010), dot(g100, g100), dot(g110, g110));
	g000 *= norm0.x;
	g010 *= norm0.y;
	g100 *= norm0.z;
	g110 *= norm0.w;
	vec4 norm1 = 1.79284291400159 - 0.85373472095314 * vec4(dot(g001, g001), dot(g011, g011), dot(g101, g101), dot(g111, g111));
	g001 *= norm1.x;
	g011 *= norm1.y;
	g101 *= norm1.z;
	g111 *= norm1.w;
	
	float n000 = dot(g000, Pf0);
	float n100 = dot(g100, vec3(Pf1.x, Pf0.yz));
	float n010 = dot(g010, vec3(Pf0.x, Pf1.y, Pf0.z));
	float n110 = dot(g110, vec3(Pf1.xy, Pf0.z));
	float n001 = dot(g001, vec3(Pf0.xy, Pf1.z));
	float n101 = dot(g101, vec3(Pf1.x, Pf0.y, Pf1.z));
	float n011 = dot(g011, vec3(Pf0.x, Pf1.yz));
	float n111 = dot(g111, Pf1);
	
	vec3 fade_xyz = Pf0 * Pf0 * Pf0 * (Pf0 * (Pf0 * 6.0 - 15.0) + 10.0);
	vec4 n_z = mix(vec4(n000, n100, n010, n110), vec4(n001, n101, n011, n111), fade_xyz.z);
	vec2 n_yz = mix(n_z.xy, n_z.zw, fade_xyz.y);
	float n_xyz = mix(n_yz.x, n_yz.y, fade_xyz.x); 
	return 2.2 * n_xyz;
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s = perlin3dNoiseFunc(vec3((%s.xy+%s.xy) * %s, %s));" % [
output_vars[0], input_vars[0], input_vars[1], input_vars[2], input_vars[3]]
