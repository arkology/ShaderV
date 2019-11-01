tool
extends VisualShaderNodeCustom
class_name VisualShaderToolsRandomFloatInput

func _get_name():
	return "RandomFloatInput"

func _get_category():
	return "Tools"

#func _get_subcategory():
#	return ""

func _get_description():
	return "Returns random float based on input value"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_input_port_count():
	return 1

func _get_input_port_name(port):
	return "input"

func _get_input_port_type(port):
	set_input_port_default_value(0, Vector3(0, 0, 0))
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_output_port_count():
	return 1

func _get_output_port_name(port):
	return "rand"

func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_code(input_vars, output_vars, mode, type):
	return output_vars[0] + " = fract(sin(dot(%s.xy, vec2(12.9898, 78.233))) * 43758.5453123);" % input_vars[0]
