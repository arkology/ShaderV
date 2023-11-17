@tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAtonemap

func _init():
	set_input_port_default_value(1, 0.0)
	set_input_port_default_value(2, 1.0)

func _get_name() -> String:
	return "Tonemap"

func _get_category() -> String:
	return "RGBA"

#func _get_subcategory():
#	return ""

#func _get_description() -> String:
#	return ""

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_input_port_count() -> int:
	return 3

func _get_input_port_name(port: int):
	match port:
		0:
			return "color"
		1:
			return "exposure"
		2:
			return "gamma"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "col"

func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_global_code(mode):
	var path = self.get_script().get_path().get_base_dir()
	return '#include "' + path + '/tonemap.gdshaderinc"'

func _get_code(input_vars, output_vars, mode, type):
	return "%s = _tonemapFunc(%s, %s, %s);" % [
output_vars[0], input_vars[0], input_vars[1], input_vars[2]]
