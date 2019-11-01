tool
extends VisualShaderNodeCustom
class_name VisualShaderToolsSinTIME

func _get_name():
	return "SinTIME"

func _get_category():
	return "Tools"

#func _get_subcategory():
#	return ""

func _get_description():
	return "Returns sin(TIME)"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_input_port_count():
	return 0

func _get_output_port_count():
	return 1

func _get_output_port_name(port):
	return "out"

func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_code(input_vars, output_vars, mode, type):
	return output_vars[0] + " = sin(TIME);"
