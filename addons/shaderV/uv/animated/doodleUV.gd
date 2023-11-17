@tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeUVdoodle

func _init():
	set_input_port_default_value(1, 0.5)
	set_input_port_default_value(2, 4)
	set_input_port_default_value(3, 0.7)
	set_input_port_default_value(4, 0.065)
	set_input_port_default_value(5, 0.0)

func _get_name() -> String:
	return "DoodleUV"

func _get_category() -> String:
	return "UV"

func _get_subcategory() -> String:
	return "Animated"

func _get_description() -> String:
	return "Doodle UV effect"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_input_port_count() -> int:
	return 6

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "frameTime"
		2:
			return "frameCount"
		3:
			return "lacunarity"
		4:
			return "maxOffset"
		5:
			return "time"

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
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "uv"

func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_global_code(mode):
	var path = self.get_script().get_path().get_base_dir()
	return '#include "' + path + '/doodleUV.gdshaderinc"'

func _get_code(input_vars, output_vars, mode, type):
	var uv = "UV"
	
	if input_vars[0]:
		uv = input_vars[0]
	
	return "%s.xy = _doodleUVFunc(%s.xy, %s, %s, %s, int(%s), %s);" % [
			output_vars[0], uv, input_vars[4], input_vars[5], input_vars[1], input_vars[2], input_vars[3]]
