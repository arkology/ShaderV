tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAposterize

func _init() -> void:
	set_input_port_default_value(1, 8.0)

func _get_name() -> String:
	return "Posterize"

func _get_category() -> String:
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return "Rounds values based on the value coming through [steps]"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 2

func _get_input_port_name(port: int):
	match port:
		0:
			return "color"
		1:
			return "steps"

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
vec3 p0ster1zeFunc(vec3 _col_p0sr1ze, float _steps_p0sterize){
	return floor(_col_p0sr1ze * _steps_p0sterize) / (_steps_p0sterize - 1.0);
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s = p0ster1zeFunc(%s, %s);" % [output_vars[0], input_vars[0], input_vars[1]]
