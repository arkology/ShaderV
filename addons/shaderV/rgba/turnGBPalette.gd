@tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAturnGameBoyPalette

func _init():
	set_input_port_default_value(1, 1.5)

func _get_name() -> String:
	return "TurnGameBoyPalette"

func _get_category() -> String:
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return "Swaps color to GameBoy palette"

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
		0:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "col"

func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_global_code(mode):
	var path = self.get_script().get_path().get_base_dir()
	return '#include "' + path + '/turnGBPalette.gdshaderinc"'

func _get_code(input_vars, output_vars, mode, type):
	return "%s = _gameboyPaletteFunc(%s, %s);" % [output_vars[0], input_vars[0], input_vars[1]]
