tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAcolorCorrectionAdjustment

func _get_name() -> String:
	return "ColorCorrectionAdjustment"

func _get_category() -> String:
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return "Full analog of color correction adjustment of environment in Godot"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 2

func _get_input_port_name(port: int):
	match port:
		0:
			return "color"
		1:
			return "corrector"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_SAMPLER

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "col"

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_global_code(mode: int) -> String:
	return """
vec3 applyC0l0rC0rrecti0nFunc(vec3 _c0l_c0rr, sampler2D _tex_c0rr) {
	_c0l_c0rr.r = texture(_tex_c0rr, vec2(_c0l_c0rr.r, 0.0)).r;
	_c0l_c0rr.g = texture(_tex_c0rr, vec2(_c0l_c0rr.g, 0.0)).g;
	_c0l_c0rr.b = texture(_tex_c0rr, vec2(_c0l_c0rr.b, 0.0)).b;
	return _c0l_c0rr;
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s = applyC0l0rC0rrecti0nFunc(%s, %s);" % [
output_vars[0], input_vars[0], input_vars[1]]
