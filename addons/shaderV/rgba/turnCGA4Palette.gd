tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAturnCGA4Palette

func _init() -> void:
	set_input_port_default_value(1, 1.5)

func _get_name() -> String:
	return "TurnCGA4Palette"

func _get_category() -> String:
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return "Swaps color to CGA 4-color palette"

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
vec3 cg4Pa1etteFunc(vec3 _c0l_cga, float _g4mm4_cga){
	_c0l_cga = pow(_c0l_cga, vec3(_g4mm4_cga));
	float _gr4y_c0l_cga4 = 0.21 * _c0l_cga.r + 0.71 * _c0l_cga.g + 0.07 * _c0l_cga.b;
	vec3 _re5_c0l_cga4 = vec3(0.0);
	
	if      (_gr4y_c0l_cga4 <= 1.0/4.0)
		_re5_c0l_cga4 = vec3(0.0,  0.0,  0.0);
	else if (_gr4y_c0l_cga4 <= 2.0/4.0)
		_re5_c0l_cga4 = vec3(1.0,  0.33, 1.0);
	else if (_gr4y_c0l_cga4 <= 3.0/4.0)
		_re5_c0l_cga4 = vec3(0.33, 1.0,  1.0);
	else if (_gr4y_c0l_cga4 <= 4.0/4.0)
		_re5_c0l_cga4 = vec3(1.0,  1.0,  1.0);
	
	return _re5_c0l_cga4;
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s = cg4Pa1etteFunc(%s, %s);" % [output_vars[0], input_vars[0], input_vars[1]]
