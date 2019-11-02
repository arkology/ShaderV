tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAgrayscale

func _get_name():
	return "Greyscale"

func _get_category():
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description():
	return "Improved grayscale with gray factor"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count():
	return 2

func _get_input_port_name(port):
	match port:
		0:
			return "color"
		1:
			return "factor"

func _get_input_port_type(port):
	set_input_port_default_value(1, 1.0)
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count():
	return 1

func _get_output_port_name(port):
	match port:
		0:
			return "col"

func _get_output_port_type(port):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR

func _get_global_code(mode):
	return """
vec3 grayscaleFunc(vec3 _c0l0r_grayscale, float _gray_fact0r){
	_gray_fact0r = min(max(_gray_fact0r, 0.0), 1.0);
	return _c0l0r_grayscale * (1.0 - _gray_fact0r) + (0.21 * _c0l0r_grayscale.r + 0.71 * _c0l0r_grayscale.g + 0.07 * _c0l0r_grayscale.b) * _gray_fact0r;
}
"""

func _get_code(input_vars, output_vars, mode, type):
	return "%s = grayscaleFunc(%s, %s);" % [output_vars[0],input_vars[0], input_vars[1]]
