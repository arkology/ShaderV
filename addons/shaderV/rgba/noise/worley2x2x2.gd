tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeNoiseWorley2x2x2

func _init() -> void:
	set_input_port_default_value(1, Vector3(0, 0, 0))
	set_input_port_default_value(2, 5)
	set_input_port_default_value(3, 1)
	set_input_port_default_value(4, 0)

func _get_name() -> String:
	return "WorleyNoise2x2x2"

func _get_category() -> String:
	return "RGBA"

func _get_subcategory() -> String:
	return "Noise"

func _get_description() -> String:
	return "2x2x2 worley noise"

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
			return "jitter"
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

func _get_output_port_name(port: int) -> String:
	return "F1"

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_global_code(mode: int) -> String:
	return """
float cellular2x2x2NoiseFunc(vec3 P, float _jitter_w2x2x2) {
	float K = 0.142857142857;
	float Ko = 0.428571428571;
	float K2 = 0.020408163265306;
	float Kz = 0.166666666667;
	float Kzo = 0.416666666667;
	
	vec3 Pi = floor(P)- floor(floor(P) * (1.0 / 289.0)) * 289.0;
	vec3 Pf = fract(P);
	vec4 Pfx = Pf.x + vec4(0.0, -1.0, 0.0, -1.0);
	vec4 Pfy = Pf.y + vec4(0.0, 0.0, -1.0, -1.0);
	vec4 p = (34.0*(Pi.x+vec4(0.0,1.0,0.0,1.0))+1.0)*(Pi.x+vec4(0.0,1.0,0.0,1.0))-floor((34.0*(Pi.x+vec4(0.0,1.0,0.0,1.0))+1.0)*(Pi.x+vec4(0.0,1.0,0.0,1.0))*(1.0/289.0))*289.0;
	p = (34.0*(p+Pi.y+vec4(0.0,0.0,1.0,1.0))+1.0)*(p+Pi.y+vec4(0.0,0.0,1.0,1.0))-floor((34.0*(p+Pi.y+vec4(0.0,0.0,1.0,1.0))+1.0)*(p+Pi.y+vec4(0.0,0.0,1.0,1.0))*(1.0/289.0))*289.0;
	vec4 p1 = (34.0*(p+Pi.z)+1.0)*(p+Pi.z)-floor((34.0*(p+Pi.z)+1.0)*(p+Pi.z)*(1.0/289.0))*289.0;
	vec4 p2 = (34.0*(p+Pi.z+vec4(1.0))+1.0)*(p+Pi.z+vec4(1.0))-floor((34.0*(p+Pi.z+vec4(1.0))+1.0)*(p+Pi.z+vec4(1.0))*(1.0/289.0))*289.0;
	vec4 ox1 = fract(p1*K) - Ko;
	vec4 oy1 = (floor(p1*K) - floor(floor(p1*K) * (1.0 / 7.0)) * 7.0)*K - Ko;
	vec4 oz1 = floor(p1*K2)*Kz - Kzo;
	vec4 ox2 = fract(p2*K) - Ko;
	vec4 oy2 = (floor(p2*K) - floor(floor(p2*K) * (1.0 / 7.0)) * 7.0)*K - Ko;
	vec4 oz2 = floor(p2*K2)*Kz - Kzo;
	vec4 dx1 = Pfx + _jitter_w2x2x2*ox1;
	vec4 dy1 = Pfy + _jitter_w2x2x2*oy1;
	vec4 dz1 = Pf.z + _jitter_w2x2x2*oz1;
	vec4 dx2 = Pfx + _jitter_w2x2x2*ox2;
	vec4 dy2 = Pfy + _jitter_w2x2x2*oy2;
	vec4 dz2 = Pf.z - 1.0 + _jitter_w2x2x2*oz2;
	vec4 d1 = dx1 * dx1 + dy1 * dy1 + dz1 * dz1;
	vec4 d2 = dx2 * dx2 + dy2 * dy2 + dz2 * dz2;
	d1 = min(d1, d2);
	d1.xy = min(d1.xy, d1.wz);
	d1.x = min(d1.x, d1.y);
	return sqrt(d1.x);
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s = cellular2x2x2NoiseFunc(vec3((%s.xy + %s.xy) * %s, %s), min(max(%s, 0.0), 1.0));" % [
output_vars[0], input_vars[0], input_vars[1], input_vars[2], input_vars[4], input_vars[3]]
