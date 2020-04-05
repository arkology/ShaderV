tool
extends VisualShaderNodeCustom
class_name VisualShaderToolsRandomFloat

func _get_name() -> String:
	return "RandomFloat"

func _get_category() -> String:
	return "Tools"

func _get_subcategory() -> String:
	return "Random"

func _get_description() -> String:
	return "Returns random float based on UV"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_input_port_count() -> int:
	return 0

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "random"

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return output_vars[0] + " = fract(sin(dot(UV, vec2(12.9898, 78.233))) * 43758.5453123);"
