@tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAscanLinesSharp

func _init():
	set_input_port_default_value(1, 21.0)
	set_input_port_default_value(2, 0.5)
	set_input_port_default_value(3, 1.0)
	set_input_port_default_value(4, 0.0)
	set_input_port_default_value(5, Vector3(1.0, 1.0, 1.0))
	set_input_port_default_value(6, 1.0)

func _get_name() -> String:
	return "ScanLinesSharpShape"

func _get_category() -> String:
	return "RGBA"

func _get_subcategory():
	return "Shapes"

func _get_description() -> String:
	return "Sharp moving scanlines"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_input_port_count() -> int:
	return 7

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "amount"
		2:
			return "fill"
		3:
			return "speed"
		4:
			return "time"
		5:
			return "color"
		6:
			return "alpha"

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
		4:
			return VisualShaderNode.PORT_TYPE_SCALAR
		5:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		6:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count() -> int:
	return 2

func _get_output_port_name(port: int):
	match port:
		0:
			return "col"
		1:
			return "alpha"

func _get_output_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_global_code(mode):
	var path = self.get_script().get_path().get_base_dir()
	return '#include "' + path + '/scanLinesSharp.gdshaderinc"'

func _get_code(input_vars, output_vars, mode, type):
	var uv = "UV"
	
	if input_vars[0]:
		uv = input_vars[0]
	
	return """%s = %s;
%s = _scanLinesSharpFunc(%s.xy, %s, %s, %s, %s) * float(%s);""" % [
output_vars[0], input_vars[5],
output_vars[1], uv, input_vars[1], input_vars[2], input_vars[3], input_vars[4], input_vars[6]]
