@tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAblackNwhite

func _init():
	set_input_port_default_value(1, 0.5)

func _get_name() -> String:
	return "BlackAndWhite"

func _get_category() -> String:
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return "Turns color to black and white"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_input_port_count() -> int:
	return 2

func _get_input_port_name(port: int):
	match port:
		0:
			return "color"
		1:
			return "threshold"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "col"

func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_global_code(mode):
	var path = self.get_script().get_path().get_base_dir()
	return '#include "' + path + '/blackNwhite.gdshaderinc"'

func _get_code(input_vars, output_vars, mode, type):
	return "%s = blackNwhite(%s, %s);" % [output_vars[0], input_vars[0], input_vars[1]]
