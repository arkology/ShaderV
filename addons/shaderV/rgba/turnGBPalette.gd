tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAturnGameBoyPalette

func _init() -> void:
	set_input_port_default_value(1, 1.5)

func _get_name() -> String:
	return "TurnGameBoyPalette"

func _get_category() -> String:
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return "Swaps color to GameBoy palette"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 2

func _get_input_port_name(port: int):
	match port:
		0:
			return "color"
		1:
			return "threshold"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		0:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "col"

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_global_code(mode: int) -> String:
	return """
vec3 g4meb0yPa1etteFunc(vec3 _c0l_g4b0, float _g4mm4_g4b0){
	_c0l_g4b0 = pow(_c0l_g4b0, vec3(_g4mm4_g4b0));
	float _gr4y_c0l_g4b0 = 0.21 * _c0l_g4b0.r + 0.71 * _c0l_g4b0.g + 0.07 * _c0l_g4b0.b;
	vec3 _re5_c0l_g4b0 = vec3(0.0);
	
	if      (_gr4y_c0l_g4b0 <= 1.0/4.0)
		_re5_c0l_g4b0 = vec3(0.063, 0.247, 0.063);
	else if (_gr4y_c0l_g4b0 <= 2.0/4.0)
		_re5_c0l_g4b0 = vec3(0.188, 0.392, 0.188);
	else if (_gr4y_c0l_g4b0 <= 3.0/4.0)
		_re5_c0l_g4b0 = vec3(0.549, 0.667, 0.078);
	else if (_gr4y_c0l_g4b0 <= 4.0/4.0)
		_re5_c0l_g4b0 = vec3(0.612, 0.725, 0.086);
	
	return _re5_c0l_g4b0;
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s = g4meb0yPa1etteFunc(%s, %s);" % [output_vars[0], input_vars[0], input_vars[1]]
