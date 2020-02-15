tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAshiftHSV

func _init() -> void:
	set_input_port_default_value(1, 1.0)
	set_input_port_default_value(2, 1.0)
	set_input_port_default_value(3, 1.0)

func _get_name() -> String:
	return "ShiftHSV"

func _get_category() -> String:
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return """Changes hue, saturation and value of input color.
Input values recommendations:
[hue]: min=0.0, max=1.0;
[saturation]: min=0.0;
[value]: min=0.0;
"""

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 4

func _get_input_port_name(port: int):
	match port:
		0:
			return "color"
		1:
			return "hue"
		2:
			return "sat"
		3:
			return "value"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR
		3:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "col"

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_global_code(mode: int) -> String:
	return """
vec3 hsv2rgbHSVChan9eFunc(vec3 _hsv_c0l0r_HSVChan9e){
	vec4 _K_hsv2rgbHSVChan9e = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
	vec3 _p_hsv2rgbHSVChan9e = abs(fract(_hsv_c0l0r_HSVChan9e.xxx + _K_hsv2rgbHSVChan9e.xyz) * 6.0 - _K_hsv2rgbHSVChan9e.www);
	return vec3(_hsv_c0l0r_HSVChan9e.z * mix(_K_hsv2rgbHSVChan9e.xxx, 
				clamp(_p_hsv2rgbHSVChan9e - _K_hsv2rgbHSVChan9e.xxx, 0.0, 1.0),
				_hsv_c0l0r_HSVChan9e.y));
}

vec3 rgb2hvsHSVChan9eFunc(vec3 _rgb_c0l0r_HSVChan9e){
	vec4 _K_rgb2hvsHSVChan9e = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
	vec4 _p_rgb2hvsHSVChan9e = mix( vec4(_rgb_c0l0r_HSVChan9e.bg, _K_rgb2hvsHSVChan9e.wz),
									vec4(_rgb_c0l0r_HSVChan9e.gb, _K_rgb2hvsHSVChan9e.xy),
									step(_rgb_c0l0r_HSVChan9e.b, _rgb_c0l0r_HSVChan9e.g));
	vec4 _q_rgb2hvsHSVChan9e = mix( vec4(_p_rgb2hvsHSVChan9e.xyw, _rgb_c0l0r_HSVChan9e.r), 
									vec4(_rgb_c0l0r_HSVChan9e.r, _p_rgb2hvsHSVChan9e.yzx),
									step(_p_rgb2hvsHSVChan9e.x, _rgb_c0l0r_HSVChan9e.r));
	float _d_rgb2hvsHSVChan9e = _q_rgb2hvsHSVChan9e.x - min(_q_rgb2hvsHSVChan9e.w, _q_rgb2hvsHSVChan9e.y);
	return vec3(vec3(abs(_q_rgb2hvsHSVChan9e.z + (_q_rgb2hvsHSVChan9e.w - _q_rgb2hvsHSVChan9e.y) / (6.0 * _d_rgb2hvsHSVChan9e + 1.0e-10)),
					_d_rgb2hvsHSVChan9e / (_q_rgb2hvsHSVChan9e.x + 1.0e-10),
					_q_rgb2hvsHSVChan9e.x));
}

vec3 hsvChangeHSVChan9eFunc(vec3 _c0l0r_HSVChan9e, float _h_HSVChan9e, float _s_HSVChan9e, float _v_HSVChan9e){
	_c0l0r_HSVChan9e = rgb2hvsHSVChan9eFunc(_c0l0r_HSVChan9e);
	_c0l0r_HSVChan9e.r *= _h_HSVChan9e;
	_c0l0r_HSVChan9e.g *= _s_HSVChan9e;
	_c0l0r_HSVChan9e.b *= _v_HSVChan9e;
	return hsv2rgbHSVChan9eFunc(_c0l0r_HSVChan9e);
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s = hsvChangeHSVChan9eFunc(%s, %s, %s, %s);" % [
output_vars[0], input_vars[0], input_vars[1], input_vars[2], input_vars[3]]
