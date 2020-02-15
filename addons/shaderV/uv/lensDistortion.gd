tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeUVlensDistortion

func _init() -> void:
	set_input_port_default_value(1, 1.0)

func _get_name() -> String:
	return "LensDistortionUV"

func _get_category() -> String:
	return "UV"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return """Lens distortion effect.
[factor] > 0 - fisheye / barrel;
[factor] < 0 - antifisheye / pincushion"""

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 2

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "factor"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "uv"

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_global_code(mode: int) -> String:
	return """
vec2 lensD1st0rti0nFunc(vec2 _uv_d1s_1en5, float _fctr_d1s_1en5){
	vec2 _p0s_d1s_1en5 = _uv_d1s_1en5 - 0.5;
	float _d1st_d1s_1en5 = length(_p0s_d1s_1en5);
	if (_fctr_d1s_1en5 > 0.0) // fisheye / barrel
		_uv_d1s_1en5 = vec2(0.5)+normalize(_p0s_d1s_1en5)*tan(_d1st_d1s_1en5*_fctr_d1s_1en5)*0.70711/tan(0.70711*_fctr_d1s_1en5);
	else if (_fctr_d1s_1en5 < 0.0) // antifisheye / pincushion
		_uv_d1s_1en5 = vec2(0.5)+normalize(_p0s_d1s_1en5)*atan(_d1st_d1s_1en5*-_fctr_d1s_1en5*10.0)*0.5/atan(-_fctr_d1s_1en5*0.5*10.0);
	return _uv_d1s_1en5;
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s.xy = lensD1st0rti0nFunc(%s.xy, %s);" % [output_vars[0], input_vars[0], input_vars[1]]
