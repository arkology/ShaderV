@tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeNoisePerlin2d

func _init():
	set_input_port_default_value(1, Vector3(0, 0, 0))
	set_input_port_default_value(2, 5.0)
	set_input_port_default_value(3, Vector3(0.0, 0.0, 0.0))

func _get_name() -> String:
	return "PerlinNoise2D"

func _get_category() -> String:
	return "RGBA"

func _get_subcategory() -> String:
	return "Noise"

func _get_description() -> String:
	return """Classic 2d perlin noise with ability to set period.
If you dont want any peroid - set it to zero"""

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_input_port_count() -> int:
	return 4

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "offset"
		2:
			return "scale"
		3:
			return "period"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR
		3:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int):
	match port:
		0:
			return "result"

func _get_output_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_global_code(mode):
	var path = self.get_script().get_path().get_base_dir()
	return '#include "' + path + '/perlin2d.gdshaderinc"'

func _get_code(input_vars, output_vars, mode, type):
	var uv = "UV"
	
	if input_vars[0]:
		uv = input_vars[0]
	
	return "%s = _perlin2dNoiseFunc((%s.xy+%s.xy)*%s, %s.xy);" % [
output_vars[0], uv, input_vars[1], input_vars[2], input_vars[3]]
