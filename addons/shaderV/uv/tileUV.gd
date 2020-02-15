tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeUVtile

func _init() -> void:
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

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

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
			return VisualShaderNode.PORT_TYPE_VECTOR
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

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_global_code(mode: int) -> String:
	return """
vec2 t1leMapUV(vec2 _uv_t1le_t1mp, float _w1dth_t1mp, float _he1ght_t1mp, float _t1le_nmbr_t1mp){
	_t1le_nmbr_t1mp = min(max(floor(_t1le_nmbr_t1mp), 0.0), _w1dth_t1mp * _he1ght_t1mp - 1.0);
	vec2 tcrcp = vec2(1.0) / vec2(_w1dth_t1mp, _he1ght_t1mp);
	float ty =floor(_t1le_nmbr_t1mp * tcrcp.x);
	float tx = _t1le_nmbr_t1mp - _w1dth_t1mp * ty;
	return (_uv_t1le_t1mp + vec2(tx, ty)) * tcrcp;
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s.xy = t1leMapUV(%s.xy, %s, %s, %s);" % [
output_vars[0], input_vars[0], input_vars[1], input_vars[2], input_vars[3]]
