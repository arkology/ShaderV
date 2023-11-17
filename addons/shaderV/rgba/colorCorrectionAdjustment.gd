@tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAcolorCorrectionAdjustment

func _get_name() -> String:
	return "ColorCorrectionAdjustment"

func _get_category() -> String:
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return "Full analog of color correction adjustment of environment in Godot"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_input_port_count() -> int:
	return 2

func _get_input_port_name(port: int):
	match port:
		0:
			return "color"
		1:
			return "corrector"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		1:
			return VisualShaderNode.PORT_TYPE_SAMPLER

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "col"

func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_global_code(mode):
	var path = self.get_script().get_path().get_base_dir()
	return '#include "' + path + '/colorCorrectionAdjustment.gdshaderinc"'

func _get_code(input_vars, output_vars, mode, type):
	return "%s = _applyColorCorrectionFunc(%s, %s);" % [
			output_vars[0], input_vars[0], input_vars[1]]
