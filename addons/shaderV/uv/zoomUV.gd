tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeUVzoom

func _get_name():
	return "ZoomUV"

func _get_category():
	return "UV"

#func _get_subcategory():
#	return ""

func _get_description():
	return "Zoom UV relative to pivot vector"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count():
	return 3

func _get_input_port_name(port):
	match port:
		0:
			return "uv"
		1:
			return "zoomFactor"
		2:
			return "pivot"

func _get_input_port_type(port):
	set_input_port_default_value(1, 1.0)
	set_input_port_default_value(2, Vector3(0.5, 0.5, 0))
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
		2:
			return VisualShaderNode.PORT_TYPE_VECTOR

func _get_output_port_count():
	return 1

func _get_output_port_name(port):
	return "uv"

func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_code(input_vars, output_vars, mode, type):
	return output_vars[0] + " = (%s - %s) * %s + %s;" % [input_vars[0], input_vars[2], input_vars[1], input_vars[2]]
