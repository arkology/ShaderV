tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAfireFX

func _init() -> void:
	set_input_port_default_value(1, Vector3(0, 1, 0))
	set_input_port_default_value(2, 0.3)
	set_input_port_default_value(3, Vector3(1, 1, 0))
	set_input_port_default_value(4, 1.0)
	set_input_port_default_value(5, Vector3(1, 0.5, 0))
	set_input_port_default_value(6, 1.0)
	set_input_port_default_value(7, Vector3(1, 0, 0))
	set_input_port_default_value(8, 1.0)
	set_input_port_default_value(9, 0)
	set_input_port_default_value(10, 0.4)
	set_input_port_default_value(11, 0.2)
	set_input_port_default_value(12, 0.0)

func _get_name() -> String:
	return "FireFX"

func _get_category() -> String:
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return """3-step fire based on perling noise"""

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 13

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "direction"
		2:
			return "speed"
		3:
			return "color1"
		4:
			return "alpha1"
		5:
			return "color2"
		6:
			return "alpha2"
		7:
			return "color3"
		8:
			return "alpha3"
		9:
			return "col1pos"
		10:
			return "col2pos"
		11:
			return "col3pos"
		12:
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
			return VisualShaderNode.PORT_TYPE_VECTOR
		4:
			return VisualShaderNode.PORT_TYPE_SCALAR
		5:
			return VisualShaderNode.PORT_TYPE_VECTOR
		6:
			return VisualShaderNode.PORT_TYPE_SCALAR
		7:
			return VisualShaderNode.PORT_TYPE_VECTOR
		8:
			return VisualShaderNode.PORT_TYPE_SCALAR
		9:
			return VisualShaderNode.PORT_TYPE_SCALAR
		10:
			return VisualShaderNode.PORT_TYPE_SCALAR
		11:
			return VisualShaderNode.PORT_TYPE_SCALAR
		12:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count() -> int:
	return 2

func _get_output_port_name(port: int):
	match port:
		0:
			return "col"
		1:
			return "alpha"

func _get_output_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_global_code(mode: int) -> String:
	return """
float cnoiseFireFXTempFunc(vec3 P) {
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
	
	ix = ((ix*34.0)+1.0)*ix - floor(((ix*34.0)+1.0)*ix * (1.0 / 289.0)) * 289.0;
	vec4 ixy = (((ix + iy)*34.0)+1.0)*(ix + iy) - floor((((ix + iy)*34.0)+1.0)*(ix + iy) * (1.0 / 289.0)) * 289.0;
	vec4 ixy0 = (((ixy + iz0) * 34.0)+1.0)* (ixy + iz0) - floor((( (ixy + iz0) *34.0)+1.0)* (ixy + iz0) * (1.0 / 289.0)) * 289.0;
	vec4 ixy1 = (((ixy + iz1)*34.0)+1.0)*(ixy + iz1) - floor((((ixy + iz1)*34.0)+1.0)*(ixy + iz1) * (1.0 / 289.0)) * 289.0;
	
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
float perlingFbmFireFXTempFunc(vec2 _pos, float _octaves, float _intencity, float persistence, float _scale, float _time) {
	float final = 0.0;
	float amplitude = _intencity;
	for(float i = 0.0; i < _octaves; i++){
		final += cnoiseFireFXTempFunc(vec3(_pos * _scale, _time)) * amplitude;
		_scale *= 2.0;
		amplitude *= persistence;
	}
	return (min(final, 1.0) + 1.0) * 0.5;
}
vec4 fireFXFunc(vec2 _uv_fire, vec2 _dir_fire, float _speed_fire, float _time_fire,
	vec4 _col1_fire, vec4 _col2_fire, vec4 _col3_fire,
	float _col1_pos, float _col2_pos, float _col3_pos){
	float _x_pos = mix(0.0, 1.0, _uv_fire.y);
	_uv_fire.x -= _dir_fire.x * _time_fire * _speed_fire;
	_uv_fire.y += _dir_fire.y * _time_fire * _speed_fire;
	float _y_pos = perlingFbmFireFXTempFunc(_uv_fire, 8.0, 0.4, 1.0, 1.0, 1.0);
	float _1 = step(_y_pos, _x_pos - _col1_pos);
	float _3 = step(_y_pos, _x_pos - _col3_pos);
	float L1 = _1 - _3;
	vec4 col = vec4(1.0);
	col = mix(_col1_fire, _col3_fire, L1);
	
	float _2 = step(_y_pos, _x_pos - _col2_pos);
	float L2 = _3 - _2;
	col.rgb = mix(col.rgb, _col2_fire.rgb, L2);
	col = mix(vec4(0.0), col, _1);
	return col;
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return """vec4 %s%s = fireFXFunc(%s.xy, %s.xy, %s, %s, vec4(%s, %s), vec4(%s, %s), vec4(%s, %s), %s, %s, %s);
%s = %s%s.rgb;
%s = %s%s.a;""" % [
output_vars[0], output_vars[1], input_vars[0], input_vars[1], input_vars[2], input_vars[12], input_vars[3], input_vars[4],
				input_vars[5], input_vars[6], input_vars[7], input_vars[8], input_vars[9], input_vars[10], input_vars[11], 
output_vars[0], output_vars[0], output_vars[1],
output_vars[1], output_vars[0], output_vars[1]]
