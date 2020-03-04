tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeUVdistortionAnimated

func _init() -> void:
	set_input_port_default_value(1, 0)
	set_input_port_default_value(2, 0)
	set_input_port_default_value(3, 0)
	set_input_port_default_value(4, 0)
	set_input_port_default_value(5, 1)
	set_input_port_default_value(6, 0)

func _get_name() -> String:
	return "DistortionUVAnimated"

func _get_category() -> String:
	return "UV"

func _get_subcategory() -> String:
	return "Animated"

func _get_description() -> String:
	return "Animated wave-like UV distortion"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 7

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "waveX"
		2:
			return "waveY"
		3:
			return "distortX"
		4:
			return "distortY"
		5:
			return "speed"
		6:
			return "time"

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
		4:
			return VisualShaderNode.PORT_TYPE_SCALAR
		5:
			return VisualShaderNode.PORT_TYPE_SCALAR
		6:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "uv"

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_global_code(mode: int) -> String:
	return """
vec2 d1stort1onUVAnimatedFunc(vec2 _uv_d1st, float _d1stX_d1st, float _d1stY_d1st, float _waveX_d1st, float _waveY_d1st, float _spd_d1st, float _t1me_d1st){
	_uv_d1st.x += sin(_uv_d1st.y * _waveX_d1st + _t1me_d1st * _spd_d1st) * _d1stX_d1st;
	_uv_d1st.y += sin(_uv_d1st.x * _waveY_d1st + _t1me_d1st * _spd_d1st) * _d1stY_d1st;
	return _uv_d1st;
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s.xy = d1stort1onUVAnimatedFunc(%s.xy, %s, %s, %s, %s, %s, %s);" % [
	output_vars[0], input_vars[0], input_vars[3], input_vars[4], input_vars[1], input_vars[2], input_vars[5], input_vars[6]]
