@tool
extends VisualShaderNodeCustom
class_name VisualShaderToolsRandomFloatImproved

func _init():
	set_input_port_default_value(1, 1.0)
	set_input_port_default_value(2, Vector3(0.0, 0.0, 0.0))

func _get_name() -> String:
	return "RandomFloatImproved"

func _get_category() -> String:
	return "Tools"

func _get_subcategory() -> String:
	return "Random"

func _get_description() -> String:
	return "Improved version of classic random function. Classic random can produce artifacts. This one - doesn't."

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_input_port_count() -> int:
	return 3

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "scale"
		2:
			return "offset"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
		2:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "rnd"

func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_global_code(mode):
	var path = self.get_script().get_path().get_base_dir()
	return '#include "' + path + '/randomFloatImproved.gdshaderinc"'

func _get_code(input_vars, output_vars, mode, type):
	var uv = "UV"
	
	if input_vars[0]:
		uv = input_vars[0]
	
	return "%s = _randImproved(%s.xy * %s + %s.xy);" % [
output_vars[0], uv, input_vars[1], input_vars[2]]
