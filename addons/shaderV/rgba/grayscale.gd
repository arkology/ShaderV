tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAgrayscale

func _init() -> void:
	set_input_port_default_value(1, 1.0)

func _get_name() -> String:
	return "GrayscalePlus"

func _get_category() -> String:
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return "Improved grayscale with gray factor"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 2

func _get_input_port_name(port: int):
	match port:
		0:
			return "color"
		1:
			return "factor"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "col"

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_global_code(mode: int) -> String:
	return """
vec3 grayscaleFunc(vec3 _c0l0r_grayscale, float _gray_fact0r){
	_gray_fact0r = min(max(_gray_fact0r, 0.0), 1.0);
	return _c0l0r_grayscale * (1.0 - _gray_fact0r) + (0.21 * _c0l0r_grayscale.r + 0.71 * _c0l0r_grayscale.g + 0.07 * _c0l0r_grayscale.b) * _gray_fact0r;
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s = grayscaleFunc(%s, %s);" % [output_vars[0], input_vars[0], input_vars[1]]
