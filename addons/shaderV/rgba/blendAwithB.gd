tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAblend

func _init() -> void:
	set_input_port_default_value(1, 1.0)
	set_input_port_default_value(3, 1.0)
	set_input_port_default_value(4, 1.0)

func _get_name() -> String:
	return "BlendAwithB"

func _get_category() -> String:
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return "Blends colors basing on fade"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 5

func _get_input_port_name(port: int):
	match port:
		0:
			return "colorDown"
		1:
			return "alphaDown"
		2:
			return "colorUp"
		3:
			return "alphaUp"
		4:
			return "fade"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
		2:
			return VisualShaderNode.PORT_TYPE_VECTOR
		3:
			return VisualShaderNode.PORT_TYPE_SCALAR
		4:
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
vec4 blendAwithBFunc(vec4 _c0l0r_blendA_rgba, vec4 _c0l0r_blendB_rgba, float _fade_blend_c0l0r){
	return mix(_c0l0r_blendA_rgba, _c0l0r_blendB_rgba, _c0l0r_blendB_rgba.a * _fade_blend_c0l0r);
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return """vec4 %s%s = blendAwithBFunc(vec4(%s, %s), vec4(%s, %s), %s);
%s = %s%s.rgb;
%s = %s%s.a;""" % [
output_vars[0], output_vars[1], input_vars[0], input_vars[1], input_vars[2], input_vars[3], input_vars[4],
output_vars[0], output_vars[0], output_vars[1],
output_vars[1], output_vars[0], output_vars[1]]
