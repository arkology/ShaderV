tool
extends VisualShaderNodeCustom
class_name VisualShaderToolsRandomFloatInput

func _init() -> void:
	set_input_port_default_value(0, Vector3(0, 0, 0))

func _get_name() -> String:
	return "RandomFloatInput"

func _get_category() -> String:
	return "Tools"

func _get_subcategory() -> String:
	return "Random"

func _get_description() -> String:
	return "Returns random float based on input value"

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

func _get_output_port_name(port: int) -> String:
	return "rand"

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return output_vars[0] + " = fract(sin(dot(%s.xy, vec2(12.9898, 78.233))) * 43758.5453123);" % input_vars[0]
