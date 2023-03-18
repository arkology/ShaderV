@tool
extends VisualShaderNodeCustom
class_name VisualShaderToolsRelay

# Almost completely useless node xD

func _get_name() -> String:
	return "Relay"

func _get_category() -> String:
	return "Tools"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return "Outputs its input, may be useful for organizing node connections. Works with booleans, vectors and scalars. Also can be used as preview node"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_MAX

func _get_input_port_count() -> int:
	return 1

func _get_input_port_name(port: int) -> String:
	return "i"

func _get_input_port_type(port):
	return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "o"

func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_code(input_vars, output_vars, mode, type):
	return output_vars[0] + " = " + input_vars[0]

