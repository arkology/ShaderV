tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAcreateRect

func _get_name():
	return "RectCreate"

func _get_category():
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description():
	return "Rectangle creation"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count():
	return 4

func _get_input_port_name(port):
	match port:
		0:
			return "uv"
		1:
			return "pos"
		2:
			return "scale"
		3:
			return "color"

func _get_input_port_type(port):
	set_input_port_default_value(1, Vector3(0.5, 0.5, 0))
	set_input_port_default_value(2, Vector3(0.5, 0.5, 0.0))
	set_input_port_default_value(3, Vector3(1.0, 1.0, 1.0))
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR
		2:
			return VisualShaderNode.PORT_TYPE_VECTOR
		3:
			return VisualShaderNode.PORT_TYPE_VECTOR

func _get_output_port_count():
	return 2

func _get_output_port_name(port):
	match port:
		0:
			return "col"
		1:
			return "alpha"

func _get_output_port_type(port):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_global_code(mode):
	return """
float rectCreati0nFunc(vec2 _uv_rect_generate, vec2 _pos_rect_generate, vec2 _size_rect_generate){
	vec2 sw_rect_gen = _pos_rect_generate - _size_rect_generate / 2.0;
	vec2 ne_rect_gen = _pos_rect_generate + _size_rect_generate / 2.0;
	vec2 _pct_temp_var = step(sw_rect_gen, _uv_rect_generate);
	_pct_temp_var -= step(ne_rect_gen, _uv_rect_generate);
	return _pct_temp_var.x * _pct_temp_var.y;
}
"""

func _get_code(input_vars, output_vars, mode, type):
	return """%s = %s;
%s = rectCreati0nFunc(%s.xy, %s.xy, %s.xy);""" % [
output_vars[0],input_vars[3],
output_vars[1], input_vars[0], input_vars[1], input_vars[2]]
