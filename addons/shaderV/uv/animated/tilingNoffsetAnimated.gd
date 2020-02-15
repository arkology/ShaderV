tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeUVtilingNoffsetAnimated

func _init() -> void:
	set_input_port_default_value(1, Vector3(0.0, 0.0, 0.0))
	set_input_port_default_value(2, 0.0)

func _get_name() -> String:
	return "TilingAndOffsetUVAnimated"

func _get_category() -> String:
	return "UV"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return "Animated UV tiling with given [offset] speed"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 3

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "offset"
		2:
			return "time"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "uv"

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_global_code(mode: int) -> String:
	return """
vec2 tilingNoffsetAnimatedFunc(vec2 _uv_tN0A, float _t1me_tN0A, vec2 _offset_tN0A){
	return vec2(mod((_uv_tN0A.x + _offset_tN0A.x * _t1me_tN0A), 1.0), mod((_uv_tN0A.y + _offset_tN0A.y * _t1me_tN0A), 1.0));
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s.xy = %s.xy + tilingNoffsetAnimatedFunc(%s.xy, %s, %s.xy);" % [
output_vars[0], output_vars[0], input_vars[0], input_vars[2], input_vars[1]]
