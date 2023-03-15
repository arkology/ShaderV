@tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAshiftHSV

func _init():
	set_input_port_default_value(1, 1.0)
	set_input_port_default_value(2, 1.0)
	set_input_port_default_value(3, 1.0)

func _get_name() -> String:
	return "ShiftHSV"

func _get_category() -> String:
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return """Changes hue, saturation and value of input color.
Input values recommendations:
[hue]: min=0.0, max=1.0;
[saturation]: min=0.0;
[value]: min=0.0;
"""

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_input_port_count() -> int:
	return 4

func _get_input_port_name(port: int):
	match port:
		0:
			return "color"
		1:
			return "hue"
		2:
			return "sat"
		3:
			return "value"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR
		3:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "col"

func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_global_code(mode):
	var code : String = preload("shiftHSV.gdshaderinc").code
	return code

func _get_code(input_vars, output_vars, mode, type):
	return "%s = _hsvChangeHSVChangeFunc(%s, %s, %s, %s);" % [
output_vars[0], input_vars[0], input_vars[1], input_vars[2], input_vars[3]]
