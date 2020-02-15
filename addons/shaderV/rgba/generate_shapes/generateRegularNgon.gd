tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAcreateRegularPolygon

func _init() -> void:
	set_input_port_default_value(1, Vector3(0.5, 0.5, 0))
	set_input_port_default_value(2, 3)
	set_input_port_default_value(3, Vector3(1.0, 1.0, 0.0))
	set_input_port_default_value(4, 0.0)
	set_input_port_default_value(5, 0.0)
	set_input_port_default_value(6, Vector3(1.0, 1.0, 1.0))
	set_input_port_default_value(7, 1.0)

func _get_name() -> String:
	return "RegularPolygonShape"

func _get_category() -> String:
	return "RGBA"

func _get_subcategory():
	return "Shapes"

func _get_description() -> String:
	return "Regular N-gon with 3+ sides"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 8

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "pos"
		2:
			return "sides"
		3:
			return "size"
		4:
			return "angle"
		5:
			return "smooth"
		6:
			return "color"
		7:
			return "alpha"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR
		3:
			return VisualShaderNode.PORT_TYPE_VECTOR
		4:
			return VisualShaderNode.PORT_TYPE_SCALAR
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
float p0lyg0nFunc(vec2 _uv_p0lyg0n, vec2 _pos_p0lyg0n, vec2 _size_p0lyg0n, float _sides_p0lyg0n, float _angle_p0lyg0n, float _smooth_p0lyg0n){
	_uv_p0lyg0n = (_uv_p0lyg0n - _pos_p0lyg0n) / (_size_p0lyg0n * 2.0);
	float a_p0lyg0n = atan(_uv_p0lyg0n.x, _uv_p0lyg0n.y) + _angle_p0lyg0n;
	float r_p0lyg0n = 6.28318530718 / float(int(max(_sides_p0lyg0n, 3.0)));
	float d_p0lyg0n = cos(floor(0.5 + a_p0lyg0n / r_p0lyg0n) * r_p0lyg0n - a_p0lyg0n) * length(_uv_p0lyg0n);
	return (max(sign(_smooth_p0lyg0n - 0.0), 0.0) * ( 1.0 - smoothstep(0.1 - 0.0001, 0.1 + _smooth_p0lyg0n, d_p0lyg0n) ) +
			(max(sign(-_smooth_p0lyg0n + 0.0), 0.0)) * ( 1.0 - smoothstep(0.1 + _smooth_p0lyg0n - 0.0001, 0.1, d_p0lyg0n) ) +
			(1.0 - abs(sign(_smooth_p0lyg0n - 0.0))) * ( 1.0 - step(0.1, d_p0lyg0n)) );
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return """%s = %s;
%s = p0lyg0nFunc(%s.xy, %s.xy, %s.xy, %s, %s, %s) * %s;""" % [
output_vars[0], input_vars[6],
output_vars[1], input_vars[0], input_vars[1], input_vars[3], input_vars[2], input_vars[4], input_vars[5], input_vars[7]]
