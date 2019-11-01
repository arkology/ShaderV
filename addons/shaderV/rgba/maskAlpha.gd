tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAmaskAlpha

func _get_name():
	return "MaskAlpha"

func _get_category():
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description():
	return "Color masking based on mask alpha"

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
			return "maskAlpha"

func _get_input_port_type(port):
	set_input_port_default_value(1, 1)
	set_input_port_default_value(2, 1)
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
vec4 maskAlphaFunc(vec4 _col_to_mask_with_alpha, float _mask_alpha_to_mask_using_alpha){
	return _col_to_mask_with_alpha * _mask_alpha_to_mask_using_alpha;
}
"""

func _get_code(input_vars, output_vars, mode, type):
	return """%s = maskAlphaFunc(vec4(%s, %s), %s).rgb;
%s = maskAlphaFunc(vec4(%s, %s), %s).a;""" % [
output_vars[0], input_vars[0], input_vars[1], input_vars[2],
output_vars[1], input_vars[0], input_vars[1], input_vars[2]]
