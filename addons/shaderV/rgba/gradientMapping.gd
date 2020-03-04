tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAgradientMapping

func _init() -> void:
	set_input_port_default_value(1, 1.0)
	set_input_port_default_value(2, 0.0)
	set_input_port_default_value(3, false)

func _get_name() -> String:
	return "GradientMapping"

func _get_category() -> String:
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return """Remaps colors based on average color value using [gradient].
[gradientOffset] allows to do color cycling if set TIME to [gradientOffset] and 'true' to [cycleColor]"""

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 5

func _get_input_port_name(port: int):
	match port:
		0:
			return "color"
		1:
			return "alpha"
		2:
			return "gradientOffset"
		3:
			return "cycleColor"
		4:
			return "gradient"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR
		3:
			return VisualShaderNode.PORT_TYPE_BOOLEAN
		4:
			return VisualShaderNode.PORT_TYPE_SAMPLER

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
vec4 gradientMappingFunc(vec3 _c0l_base_gm, float _grad_offset, sampler2D _palette_gm, bool _use_c0l_cycle){
	float avg_c0l = 0.2126 * _c0l_base_gm.r + 0.7152 * _c0l_base_gm.g + 0.0722 * _c0l_base_gm.b;
	if (_use_c0l_cycle){
		return texture(_palette_gm, mod(vec2(avg_c0l + _grad_offset, 0), vec2(1.0)));
	} else{
		return texture(_palette_gm, vec2(avg_c0l + _grad_offset, 0));
	}
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return """vec4 %s%s = gradientMappingFunc(%s, %s, %s, %s);
%s = %s%s.rgb;
%s = %s%s.a * %s;""" % [
output_vars[0], output_vars[1], input_vars[0], input_vars[2], input_vars[4], input_vars[3],
output_vars[0], output_vars[0], output_vars[1],
output_vars[1], output_vars[0], output_vars[1], input_vars[1]]
