tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAgradient4corners

func _get_name():
	return "Gradient4Corners"

func _get_category():
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description():
	return "Generates gradient based on corners colors"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count():
	return 9

func _get_input_port_name(port):
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

func _get_input_port_type(port):
	set_input_port_default_value(1, Vector3(1.0, 1.0, 1.0))
	set_input_port_default_value(2, 1.0)
	set_input_port_default_value(3, Vector3(1.0, 1.0, 1.0))
	set_input_port_default_value(4, 1.0)
	set_input_port_default_value(5, Vector3(1.0, 1.0, 1.0))
	set_input_port_default_value(6, 1.0)
	set_input_port_default_value(7, Vector3(1.0, 1.0, 1.0))
	set_input_port_default_value(8, 1.0)
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
vec3 gradient4cornersColorsFunc(vec2 _uv_c0rner, vec3 _top_left_c0rner, vec3 _top_right_c0rner, vec3 _bottom_left_c0rner, vec3 _bottom_right_c0rner){
	vec3 _c0l0r_t0p_c0rner = mix(_top_left_c0rner, _top_right_c0rner, _uv_c0rner.x);
	vec3 _c0l0r_b0tt0m_c0rner = mix(_bottom_left_c0rner, _bottom_right_c0rner, _uv_c0rner.x);
	return mix(_c0l0r_t0p_c0rner, _c0l0r_b0tt0m_c0rner, _uv_c0rner.y);
}
float gradient4cornersAlphaFunc(vec2 _uv_c0rner, float _top_left_c0rner, float _top_right_c0rner, float _bottom_left_c0rner, float _bottom_right_c0rner){
	float _c0l0r_t0p_c0rner = mix(_top_left_c0rner, _top_right_c0rner, _uv_c0rner.x);
	float _c0l0r_b0tt0m_c0rner = mix(_bottom_left_c0rner, _bottom_right_c0rner, _uv_c0rner.x);
	return mix(_c0l0r_t0p_c0rner, _c0l0r_b0tt0m_c0rner, _uv_c0rner.y);
}
"""

func _get_code(input_vars, output_vars, mode, type):
	return """%s = gradient4cornersColorsFunc(%s.xy, %s, %s, %s, %s);
%s = gradient4cornersAlphaFunc(%s.xy, %s, %s, %s, %s);""" % [
output_vars[0], input_vars[0], input_vars[1], input_vars[3], input_vars[5], input_vars[7],
output_vars[1], input_vars[0], input_vars[2], input_vars[4], input_vars[6], input_vars[8]]
