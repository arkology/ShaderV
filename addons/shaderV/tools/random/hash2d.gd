tool
extends VisualShaderNodeCustom
class_name VisualShaderToolsHash2D

func _get_name() -> String:
	return "HashRandom2d"

func _get_category() -> String:
	return "Tools"

func _get_subcategory() -> String:
	return "Random"

func _get_description() -> String:
	return "Hash func with vector input and scalar output"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_input_port_count() -> int:
	return 1

func _get_input_port_name(port: int) -> String:
	return "in"

func _get_input_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port ) -> String:
	return "rand"

func _get_output_port_type(port) -> int:
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return output_vars[0] + " = fract(1e4 * sin(17.0 * %s.x + %s.y * 0.1) * (0.1 + abs(sin(%s.y * 13.0 + %s.x))));" % [
	input_vars[0], input_vars[0], input_vars[0], input_vars[0]]




