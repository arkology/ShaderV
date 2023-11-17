@tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAmaskAlpha

func _init():
	set_input_port_default_value(1, 1.0)
	set_input_port_default_value(2, 1.0)

func _get_name() -> String:
	return "MaskAlpha"

func _get_category() -> String:
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return "Color masking based on mask alpha"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_input_port_count() -> int:
	return 3

func _get_input_port_name(port: int):
	match port:
		0:
			return "color"
		1:
			return "alpha"
		2:
			return "maskAlpha"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
		2:
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
	return '#include "' + path + '/maskAlpha.gdshaderinc"'

func _get_code(input_vars, output_vars, mode, type):
	return """%s = _maskAlphaFunc(vec4(%s, %s), %s).rgb;
%s = _maskAlphaFunc(vec4(%s, %s), %s).a;""" % [
output_vars[0], input_vars[0], input_vars[1], input_vars[2],
output_vars[1], input_vars[0], input_vars[1], input_vars[2]]
