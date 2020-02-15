tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAgradient4corners

func _init() -> void:
	set_input_port_default_value(1, Vector3(1.0, 1.0, 1.0))
	set_input_port_default_value(2, 1.0)
	set_input_port_default_value(3, Vector3(1.0, 1.0, 1.0))
	set_input_port_default_value(4, 1.0)
	set_input_port_default_value(5, Vector3(1.0, 1.0, 1.0))
	set_input_port_default_value(6, 1.0)
	set_input_port_default_value(7, Vector3(1.0, 1.0, 1.0))
	set_input_port_default_value(8, 1.0)

func _get_name() -> String:
	return "Gradient4Corners"

func _get_category() -> String:
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return "Generates gradient based on corners colors"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 9

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "colorTopLeft"
		2:
			return "alphaTopLeft"
		3:
			return "colorTopRight"
		4:
			return "alphaTopRight"
		5:
			return "colorBottomLeft"
		6:
			return "alphaBottomLeft"
		7:
			return "colorBottomRight"
		8:
			return "alphaBottomRight"

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
			return VisualShaderNode.PORT_TYPE_VECTOR
		6:
			return VisualShaderNode.PORT_TYPE_SCALAR
		7:
			return VisualShaderNode.PORT_TYPE_VECTOR
		8:
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
vec4 gradient4cornersFunc(vec2 _uv_c0rner, vec4 _top_left_c0rner, vec4 _top_right_c0rner, vec4 _bottom_left_c0rner, vec4 _bottom_right_c0rner){
	vec4 _c0l0r_t0p_c0rner = mix(_top_left_c0rner, _top_right_c0rner, _uv_c0rner.x);
	vec4 _c0l0r_b0tt0m_c0rner = mix(_bottom_left_c0rner, _bottom_right_c0rner, _uv_c0rner.x);
	return mix(_c0l0r_t0p_c0rner, _c0l0r_b0tt0m_c0rner, _uv_c0rner.y);
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return """vec4 %s%s = gradient4cornersFunc(%s.xy, vec4(%s, %s), vec4(%s, %s), vec4(%s, %s), vec4(%s, %s));
%s = %s%s.rgb;
%s = %s%s.a;""" % [
output_vars[0], output_vars[1], input_vars[0], input_vars[1], input_vars[2], input_vars[3],
input_vars[4], input_vars[5], input_vars[6], input_vars[7], input_vars[8],
output_vars[0], output_vars[0], output_vars[1],
output_vars[1], output_vars[0], output_vars[1]]
