tool
extends VisualShaderNodeCustom
class_name VisualShaderToolsHash

func _get_name():
	return "Hash1d"

func _get_category():
	return "Tools"

#func _get_subcategory():
#	return ""

func _get_description():
	return "Hash func with scalar input"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_input_port_count():
	return 1

func _get_input_port_name(port: int) -> String:
	return "inp"

func _get_input_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count():
	return 1

func _get_output_port_name(port):
	return "rand"

func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return output_vars[0] + " = fract(sin(" + input_vars[0] + ") * 1e4);"




