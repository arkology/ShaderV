tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeUVflip

func _get_name():
	return "FlipUV"

func _get_category():
	return "UV"

#func _get_subcategory():
#	return ""

func _get_description():
	return "Flip UV horizontal or vertical"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count():
	return 3

func _get_input_port_name(port):
	match port:
		0:
			return "uv"
		1:
			return "vert"
		2:
			return "hor"

func _get_input_port_type(port):
	set_input_port_default_value(1, false)
	set_input_port_default_value(2, false)
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_BOOLEAN
		2:
			return VisualShaderNode.PORT_TYPE_BOOLEAN

func _get_output_port_count():
	return 1

func _get_output_port_name(port):
	return "uv"

func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_global_code(mode):
	return ""

func _get_code(input_vars, output_vars, mode, type):
	return output_vars[0] + " = vec3(mix(%s.x, 1.0 - %s.x, float(%s)), mix(%s.y, 1.0 - %s.y, float(%s)), 0);" % [
	input_vars[0], input_vars[0], input_vars[1], input_vars[0], input_vars[0], input_vars[2]]
