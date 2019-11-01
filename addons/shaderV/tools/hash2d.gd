tool
extends VisualShaderNodeCustom
class_name VisualShaderToolsHash2D

func _get_name():
	return "Hash2d"

func _get_category():
	return "Tools"

#func _get_subcategory():
#	return ""

func _get_description():
	return "Hash func with vector input"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_input_port_count():
	return 1

func _get_input_port_name(port: int) -> String:
	return "inp"

func _get_input_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_output_port_count():
	return 1

func _get_output_port_name(port):
	return "rand"

func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return output_vars[0] + " = fract(1e4 * sin(17.0 * %s.x + %s.y * 0.1) * (0.1 + abs(sin(%s.y * 13.0 + %s.x))));" % [
	input_vars[0], input_vars[0], input_vars[0], input_vars[0]]




