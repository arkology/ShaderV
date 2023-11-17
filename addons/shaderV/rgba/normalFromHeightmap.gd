@tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAnormalFromHeightmap

func _init():
	set_input_port_default_value(2, Vector3(64, 64, 0))
	set_input_port_default_value(3, 10.0)
	set_input_port_default_value(4, false)
	set_input_port_default_value(5, false)
	set_input_port_default_value(6, false)

func _get_name() -> String:
	return "NormalFromHeightmap"

func _get_category() -> String:
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return """Create normal map from heightmap texture. You should provide actual size of heightmap (in pixels).
It always uses 0 lod of heightmap texture to create normalmap.
It's possible to invert X and Y of normalmap if needed.
If you provide texture with different colors (not actual heightmap) to 'heightmapSampler', you can set 'preconvertToGray' to 'true'."""

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_input_port_count() -> int:
	return 7

func _get_input_port_name(port: int):
	match port:
		0:
			return "heightmapSampler"
		1:
			return "uv"
		2:
			return "heightmapSize"
		3:
			return "strength"
		4:
			return "preconvertToGray"
		5:
			return "invertX"
		6:
			return "invertY"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_SAMPLER
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		2:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		3:
			return VisualShaderNode.PORT_TYPE_SCALAR
		4:
			return VisualShaderNode.PORT_TYPE_BOOLEAN
		5:
			return VisualShaderNode.PORT_TYPE_BOOLEAN
		6:
			return VisualShaderNode.PORT_TYPE_BOOLEAN

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "normal"

func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_global_code(mode):
	var path = self.get_script().get_path().get_base_dir()
	return '#include "' + path + '/normalFromHeightmap.gdshaderinc"'

func _get_code(input_vars, output_vars, mode, type):
	var texture = "TEXTURE"
	var uv = "UV"
	
	if input_vars[0]:
		texture = input_vars[0]
	if input_vars[1]:
		uv = input_vars[1]
	
	return "%s = _normalFromHeightmapFunc(%s.xy, %s, %s.xy, %s, %s, %s, %s);" % [
output_vars[0], uv, texture, input_vars[2], input_vars[3], input_vars[4], input_vars[5], input_vars[6]]
