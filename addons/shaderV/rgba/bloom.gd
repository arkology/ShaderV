tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAbloom

func _init() -> void:
	set_input_port_default_value(2, 1.0)

func _get_name() -> String:
	return "Bloom"

func _get_category() -> String:
	return "RGBA"

#func _get_subcategory():
#	return ""

#func _get_description() -> String:
#	return ""

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 3

func _get_input_port_name(port: int):
	match port:
		0:
			return "color"
		1:
			return "alpha"
		2:
			return "strength"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
		2:
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
vec4 bl00mFunc(vec4 _c0l_bl00m, float _strength_bl00m){
	float _gamma_bl00m = 1.0 - pow(_c0l_bl00m.r, _strength_bl00m);
	_c0l_bl00m.rgb += (_c0l_bl00m.rgb * _c0l_bl00m.a) * min(max(_strength_bl00m, 0.0), 1.0);
	return _c0l_bl00m;
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return """vec4 %s%s = bl00mFunc(vec4(%s, %s), %s);
%s = %s%s.rgb;
%s = %s%s.a""" % [
output_vars[0], output_vars[1], input_vars[0], input_vars[1], input_vars[2],
output_vars[0], output_vars[0], output_vars[1],
output_vars[1], output_vars[0], output_vars[1]]
