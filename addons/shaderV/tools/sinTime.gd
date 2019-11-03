tool
extends VisualShaderNodeCustom
class_name VisualShaderToolsSinTIME

func _get_name() -> String:
	return "SinTIME"

func _get_category() -> String:
	return "Tools"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return "Returns sin(TIME)"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_input_port_count() -> int:
	return 0

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "out"

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return output_vars[0] + " = sin(TIME);"
