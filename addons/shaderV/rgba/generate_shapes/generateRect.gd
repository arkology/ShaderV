tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAcreateRect

func _init() -> void:
	set_input_port_default_value(1, Vector3(0.5, 0.5, 0))
	set_input_port_default_value(2, Vector3(0.5, 0.5, 0.0))
	set_input_port_default_value(3, Vector3(1.0, 1.0, 1.0))
	set_input_port_default_value(4, 1.0)

func _get_name() -> String:
	return "RectShape"

func _get_category() -> String:
	return "RGBA"

func _get_subcategory():
	return "Shapes"

func _get_description() -> String:
	return "Rectangle creation"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 5

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "pos"
		2:
			return "scale"
		3:
			return "color"
		4:
			return "alpha"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR
		2:
			return VisualShaderNode.PORT_TYPE_VECTOR
		3:
			return VisualShaderNode.PORT_TYPE_VECTOR
		4:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count() -> int:
	return 2

func _get_output_port_name(port: int):
	match port:
		0:
			return "col"
		1:
			return "alpha"

func _get_output_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_global_code(mode: int) -> String:
	return """
float rectCreati0nFunc(vec2 _uv_rect_generate, vec2 _pos_rect_generate, vec2 _size_rect_generate){
	vec2 sw_rect_gen = _pos_rect_generate - _size_rect_generate / 2.0;
	vec2 ne_rect_gen = _pos_rect_generate + _size_rect_generate / 2.0;
	vec2 _pct_temp_var = step(sw_rect_gen, _uv_rect_generate);
	_pct_temp_var -= step(ne_rect_gen, _uv_rect_generate);
	return _pct_temp_var.x * _pct_temp_var.y;
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return """%s = %s;
%s = rectCreati0nFunc(%s.xy, %s.xy, %s.xy) * %s;""" % [
output_vars[0],input_vars[3],
output_vars[1], input_vars[0], input_vars[1], input_vars[2], input_vars[4]]
