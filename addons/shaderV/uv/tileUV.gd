@tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeUVtile

func _init():
	set_input_port_default_value(1, 2.0)
	set_input_port_default_value(2, 2.0)
	set_input_port_default_value(3, 0.0)

func _get_name() -> String:
	return "TileUV"

func _get_category() -> String:
	return "UV"

#func _get_subcategory() -> String:
#	return ""

func _get_description() -> String:
	return """Tile UV can be used to get UV position of tile within a tilemap.
[uv] - uv of tileset;
[Vframes] - the number of rows;
[Hframes] - the number of columns;
[frame] - current frame;"""

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_input_port_count() -> int:
	return 4

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "Vframes"
		2:
			return "Hframes"
		3:
			return "frame"

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
	return "uv"

func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_global_code(mode):
	var path = self.get_script().get_path().get_base_dir()
	return '#include "' + path + '/tileUV.gdshaderinc"'

func _get_code(input_vars, output_vars, mode, type):
	var uv = "UV"
	
	if input_vars[0]:
		uv = input_vars[0]
	
	return "%s.xy = _tileMapUV(%s.xy, %s, %s, %s);" % [
			output_vars[0], uv, input_vars[1], input_vars[2], input_vars[3]]
