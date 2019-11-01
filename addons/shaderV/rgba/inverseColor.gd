tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAinverseColor

func _get_name():
	return "InverseColor"

func _get_category():
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description():
	return "Inverse color basing on intensity"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count():
	return 3

func _get_input_port_name(port):
	match port:
		0:
			return "color"
		1:
			return "alpha"
		2:
			return "intensity"

func _get_input_port_type(port):
	set_input_port_default_value(2, 1.0)
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
		2:
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
vec3 inverseC0l0rFunc(vec3 _c0l0r_to_inverse, float _inverse_c0l0r_intensity){
	return mix(_c0l0r_to_inverse.rgb, 1.0 - _c0l0r_to_inverse.rgb, _inverse_c0l0r_intensity);
}
"""

func _get_code(input_vars, output_vars, mode, type):
	return """%s = inverseC0l0rFunc(%s, %s);
%s = %s;""" % [output_vars[0], input_vars[0],input_vars[2],
output_vars[1], input_vars[1]]
