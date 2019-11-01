tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAcreateStripesRandom

func _get_name():
	return "RandomStripes"

func _get_category():
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description():
	return "Random horizontal lines creation"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count():
	return 5

func _get_input_port_name(port):
	match port:
		0:
			return "uv"
		1:
			return "fill"
		2:
			return "amount"
		3:
			return "color"
		4:
			return "alpha"

func _get_input_port_type(port):
	set_input_port_default_value(1, 0.5)
	set_input_port_default_value(2, 20.0)
	set_input_port_default_value(3, Vector3(1.0, 1.0, 1.0))
	set_input_port_default_value(4, 1)
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR
		3:
			return VisualShaderNode.PORT_TYPE_VECTOR
		4:
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
float generateRand0mStripesFunc(vec2 _uv_stripes, float _fill_stripes, float _amount_stripes){
	_fill_stripes = min(max(_fill_stripes, 0.0), 1.0);
	return 1.0 - step(_fill_stripes, fract(sin(dot(floor(vec2(_uv_stripes.y) * _amount_stripes), vec2(12.9898, 78.233))) * 43758.5453123));
}
"""

func _get_code(input_vars, output_vars, mode, type):
	return """%s = %s;
%s = generateRand0mStripesFunc(%s.xy, %s, %s) * %s;""" % [output_vars[0], input_vars[3],
output_vars[1], input_vars[0], input_vars[1], input_vars[2], input_vars[4]]
