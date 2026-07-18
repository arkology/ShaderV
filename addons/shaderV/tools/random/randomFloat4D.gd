@tool
extends VisualShaderNodeCustom
class_name VisualShaderToolsRandomFloat4D

func _init():
	set_input_port_default_value(1, 1.0)

func _get_name() -> String:
	return "RandomFloat4D"

func _get_category() -> String:
	return "Tools"

func _get_subcategory() -> String:
	return "Random"

func _get_description() -> String:
	return "Returns random float value based on 4D input vector"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_input_port_count() -> int:
	return 3

func _get_input_port_name(port: int):
	match port:
		0:
			return "input"
		1:
			return "scale"
		2:
			return "offset"
	return ""

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR_4D
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
		2:
			return VisualShaderNode.PORT_TYPE_VECTOR_4D
	return PORT_TYPE_SCALAR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "rnd"

func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_global_code(mode):
	var path = self.get_script().get_path().get_base_dir()
	return '#include "' + path + '/randomFloat4D.gdshaderinc"'

func _get_code(input_vars, output_vars, mode, type):
	var input = input_vars[0]
	var offset = input_vars[2]
	
	# See https://github.com/godotengine/godot/pull/90850
	if not input:
		input = 'vec4(0)'
	if not offset:
		offset = 'vec4(0)'
	
	return "%s = _randFloat4D(%s * %s + %s);" % [
		output_vars[0], input, input_vars[1], offset]
