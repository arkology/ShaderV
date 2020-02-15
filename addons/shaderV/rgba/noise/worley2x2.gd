tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeNoiseWorley2x2

func _init() -> void:
	set_input_port_default_value(1, Vector3(0, 0, 0))
	set_input_port_default_value(2, 5)
	set_input_port_default_value(3, 1)

func _get_name() -> String:
	return "WorleyNoise2x2"

func _get_category() -> String:
	return "RGBA"

func _get_subcategory() -> String:
	return "Noise"

func _get_description() -> String:
	return "2x2 worley noise"

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
	return 1

func _get_output_port_name(port: int) -> String:
	return "F1"

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_global_code(mode: int) -> String:
	return """
float cellular2x2NoiseFunc(vec2 P, float _jitter_w2x2) {
	float K = 0.142857142857; // 1/7
	float K2 = 0.0714285714285; // K/2
	
	vec2 Pi = floor(P) - floor(floor(P) * (1.0 / 289.0)) * 289.0;
	vec2 Pf = fract(P);
	vec4 Pfx = Pf.x + vec4(-0.5, -1.5, -0.5, -1.5);
	vec4 Pfy = Pf.y + vec4(-0.5, -0.5, -1.5, -1.5);
	vec4 p = ((34.0*(Pi.x + vec4(0.0, 1.0, 0.0, 1.0))+1.0)*(Pi.x + vec4(0.0, 1.0, 0.0, 1.0)))-floor(((34.0*(Pi.x + vec4(0.0, 1.0, 0.0, 1.0))+1.0)*(Pi.x + vec4(0.0, 1.0, 0.0, 1.0)))*(1.0/289.0))*289.0;
	p = ((34.0*(p + Pi.y + vec4(0.0, 0.0, 1.0, 1.0))+1.0)*(p + Pi.y + vec4(0.0, 0.0, 1.0, 1.0)))-floor(((34.0*(p + Pi.y + vec4(0.0, 0.0, 1.0, 1.0))+1.0)*(p + Pi.y + vec4(0.0, 0.0, 1.0, 1.0)))*(1.0/289.0))*289.0;
	vec4 ox = (p - floor(p * (1.0 / 7.0)) * 7.0)*K+K2;
	vec4 oy = (floor(p*K) - floor(floor(p*K) * (1.0 / 7.0)) * 7.0)*K+K2;
	vec4 dx = Pfx + _jitter_w2x2*ox;
	vec4 dy = Pfy + _jitter_w2x2*oy;
	vec4 d = dx * dx + dy * dy;
	d.xy = min(d.xy, d.zw);
	d.x = min(d.x, d.y);
	return sqrt(d.x);
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s = cellular2x2NoiseFunc((%s.xy+%s.xy)*%s, min(max(%s, 0.0), 1.0));" % [
output_vars[0], input_vars[0], input_vars[1], input_vars[2], input_vars[3]]
