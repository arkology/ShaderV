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
	var code : String = preload("blackNwhite.gdshader").code
	code = code.replace("shader_type canvas_item;\n", "").replace("shader_type canvas_item;\r\n", "")
	return code

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s = blackNwhite(%s, %s);" % [output_vars[0], input_vars[0], input_vars[1]]
