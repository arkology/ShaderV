@tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeUVflip

func _init():
	set_input_port_default_value(1, false)
	set_input_port_default_value(2, false)

func _get_name() -> String:
	return "FlipUV"

func _get_category() -> String:
	return "UV"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return "Flip UV horizontal or vertical"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_input_port_count() -> int:
	return 3

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "vert"
		2:
			return "hor"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		1:
			return VisualShaderNode.PORT_TYPE_BOOLEAN
		2:
			return VisualShaderNode.PORT_TYPE_BOOLEAN

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "uv"

func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_global_code(mode):
	var path = self.get_script().get_path().get_base_dir()
	return '#include "' + path + '/flipUV.gdshaderinc"'

func _get_code(input_vars, output_vars, mode, type):
	var uv = "UV"
	
	if input_vars[0]:
		uv = input_vars[0]
	
	return "%s.xy = _flipUV(%s.xy, vec2(float(%s), float(%s)));" % [
			output_vars[0], uv, input_vars[1], input_vars[2]]
