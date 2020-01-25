tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAgradientMapping

func _get_name() -> String:
	return "GradientMapping"

func _get_category() -> String:
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return "Remaps colors based on average color value using [gradientMap] gradient"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 2

func _get_input_port_name(port: int):
	match port:
		0:
			return "color"
		1:
			return "gradientMap"

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
vec3 gradientMappingFunc(vec3 _c0l_base_gm, sampler2D _palette_gm){
	float avg_c0l = 0.2126 * _c0l_base_gm.r + 0.7152 * _c0l_base_gm.g + 0.0722 * _c0l_base_gm.b;
	return texture(_palette_gm, vec2(avg_c0l, 0)).rgb;
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s = gradientMappingFunc(%s, %s);" % [
output_vars[0], input_vars[0], input_vars[1]]
