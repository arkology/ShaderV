tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAgridShape

func _init() -> void:
	set_input_port_default_value(1, Vector3(8.0, 8.0, 0.0))
	set_input_port_default_value(2, Vector3(0.2, 0.2, 0.0))
	set_input_port_default_value(3, Vector3(0.01, 0.01, 0.0))
	set_input_port_default_value(4, Vector3(1.0, 1.0, 1.0))
	set_input_port_default_value(5, 1.0)
	set_input_port_default_value(6, Vector3(0.0, 0.0, 0.0))
	set_input_port_default_value(7, 0.0)

func _get_name() -> String:
	return "GridShape"

func _get_category() -> String:
	return "RGBA"

func _get_subcategory():
	return "Shapes"

func _get_description() -> String:
	return "Creates 2D grid."

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 8

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "cell_count"
		2:
			return "line_thickness"
		3:
			return "line_smooth"
		4:
			return "grid_color"
		5:
			return "grid_alpha"
		6:
			return "bg_color"
		7:
			return "bg_alpha"

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
			return VisualShaderNode.PORT_TYPE_VECTOR
		5:
			return VisualShaderNode.PORT_TYPE_SCALAR
		6:
			return VisualShaderNode.PORT_TYPE_VECTOR
		7:
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
vec4 gridFunc(vec2 _grid_uv, vec2 _gridline_thickness, vec2 _gridline_smooth, vec2 _gridcell_count, vec4 _grid_col, vec4 _grid_bg_col){
	vec2 _grid_vec = fract(_grid_uv * _gridcell_count);
	_grid_vec = min(_grid_vec, vec2(1.0) - _grid_vec);
	_grid_vec = smoothstep(_grid_vec - _gridline_smooth, _grid_vec + _gridline_smooth, _gridline_thickness / vec2(2.0));
	return mix(_grid_bg_col, _grid_col, clamp(_grid_vec.x + _grid_vec.y, 0.0, 1.0));
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return """vec4 %s%s = gridFunc(%s.xy, %s.xy, %s.xy, %s.xy, vec4(%s, %s), vec4(%s, %s));
%s = %s%s.rgb;
%s = %s%s.a;""" % [
output_vars[0], output_vars[1], input_vars[0], input_vars[2], input_vars[3], input_vars[1],
								input_vars[4], input_vars[5], input_vars[6], input_vars[7],
output_vars[0], output_vars[0], output_vars[1],
output_vars[1], output_vars[0], output_vars[1]]
