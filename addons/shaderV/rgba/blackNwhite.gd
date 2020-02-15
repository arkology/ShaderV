tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAblackNwhite

func _init() -> void:
	set_input_port_default_value(1, 0.5)

func _get_name() -> String:
	return "BlackAndWhite"

func _get_category() -> String:
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return "Turns color to black and white"

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
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "col"

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_global_code(mode: int) -> String:
	return """
vec3 blackNwh1teFunc(vec3 _c0l_bNw, float _thresh0ld_bNw){
	return vec3( ( (0.21 * _c0l_bNw.r + 0.71 * _c0l_bNw.g + 0.07 * _c0l_bNw.b) < _thresh0ld_bNw) ? 0.0 : 1.0);
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s = blackNwh1teFunc(%s, %s);" % [output_vars[0], input_vars[0], input_vars[1]]
