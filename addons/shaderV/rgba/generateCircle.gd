tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAcreateCircle

func _get_name():
	return "CircleCreate"

func _get_category():
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description():
	return "Circle creation"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count():
	return 8

func _get_input_port_name(port):
	match port:
		0:
			return "uv"
		1:
			return "pos"
		2:
			return "scale"
		3:
			return "inRadius"
		4:
			return "outRadius"
		5:
			return "hardness"
		6:
			return "color"
		7:
			return "alpha"

func _get_input_port_type(port):
	set_input_port_default_value(1, Vector3(0.5, 0.5, 0))
	set_input_port_default_value(2, Vector3(1.0, 1.0, 0.0))
	set_input_port_default_value(3, -0.5)
	set_input_port_default_value(4, 0.5)
	set_input_port_default_value(5, 1.0)
	set_input_port_default_value(6, Vector3(1.0, 1.0, 1.0))
	set_input_port_default_value(7, 1.0)
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR
		2:
			return VisualShaderNode.PORT_TYPE_VECTOR
		3:
			return VisualShaderNode.PORT_TYPE_SCALAR
		4:
			return VisualShaderNode.PORT_TYPE_SCALAR
		5:
			return VisualShaderNode.PORT_TYPE_SCALAR
		6:
			return VisualShaderNode.PORT_TYPE_VECTOR
		7:
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
vec4 generateCirc1eFunc(vec2 _uv_circ1e, vec2 _center_circ1e, vec2 _scale_factor_circ1e, float _innerRad_circ1e, float _outRad_circ1e, float _hard_circ1e) {
	float _innerRadiusCheck0 = min(_innerRad_circ1e, _outRad_circ1e);
	float _outerRadiusCheck0 = max(_innerRad_circ1e, _outRad_circ1e);
	
	float currentP0sitionC1rcle = length((_uv_circ1e - _center_circ1e) * _scale_factor_circ1e);
	float maxIntencityCenterC1rcle = (_outerRadiusCheck0 + _innerRadiusCheck0) * 0.5;
	float rd0 = _outerRadiusCheck0 - maxIntencityCenterC1rcle;
	float circ1eDistributi0n = min(max(abs(currentP0sitionC1rcle - maxIntencityCenterC1rcle) / rd0, 0.0), 1.0);
	vec4 _outputColor0 = vec4(1.0);
	_outputColor0.a = 1.0 - pow(circ1eDistributi0n, _hard_circ1e);
	return _outputColor0;
}
"""

func _get_code(input_vars, output_vars, mode, type):
	return """%s = %s;
%s = generateCirc1eFunc(%s.xy, %s.xy, %s.xy, %s, %s, %s).a * %s;""" % [output_vars[0],
input_vars[6], output_vars[1], input_vars[0], input_vars[1], input_vars[2], input_vars[3], input_vars[4], input_vars[5], input_vars[7]]
