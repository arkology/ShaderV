tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAhue

func _get_name() -> String:
	return "Hue"

func _get_category() -> String:
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return "Outputs an RGB color given a HUE"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 1

func _get_input_port_name(port: int):
	match port:
		0:
			return "inp"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "col"

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_global_code(mode: int) -> String:
	return """
vec3 hueFunc(float _1np_hue){
	return min(max(3.0 * abs(1.0 - 2.0 * fract(_1np_hue + vec3(0.0, -1.0 / 3.0, 1.0 / 3.0))) - 1.0 , 0.0), 1.0);
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s = hueFunc(%s);" % [output_vars[0], input_vars[0]]
