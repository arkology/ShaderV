@tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeNoiseWorley2x2x2

func _init():
	set_input_port_default_value(1, Vector3(0, 0, 0))
	set_input_port_default_value(2, 5.0)
	set_input_port_default_value(3, 1.0)
	set_input_port_default_value(4, 0.0)

func _get_name() -> String:
	return "WorleyNoise2x2x2"

func _get_category() -> String:
	return "RGBA"

func _get_subcategory() -> String:
	return "Noise"

func _get_description() -> String:
	return "2x2x2 worley noise"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_input_port_count() -> int:
	return 5

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "offset"
		2:
			return "scale"
		3:
			return "jitter"
		4:
			return "time"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR
		3:
			return VisualShaderNode.PORT_TYPE_SCALAR
		4:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "F1"

func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_global_code(mode):
	var path = self.get_script().get_path().get_base_dir()
	return '#include "' + path + '/worley2x2x2.gdshaderinc"'

func _get_code(input_vars, output_vars, mode, type):
	var uv = "UV"
	
	if input_vars[0]:
		uv = input_vars[0]
	
	return "%s = _cellular2x2x2NoiseFunc(vec3((%s.xy + %s.xy) * %s, %s), min(max(%s, 0.0), 1.0));" % [
output_vars[0], uv, input_vars[1], input_vars[2], input_vars[4], input_vars[3]]
