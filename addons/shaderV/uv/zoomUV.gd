tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeUVzoom

func _get_name() -> String:
	return "ZoomUV"

func _get_category() -> String:
	return "UV"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return "Zoom UV relative to pivot point"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 3

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "factor"
		2:
			return "pivot"

func _get_input_port_type(port: int):
	set_input_port_default_value(1, 1.0)
	set_input_port_default_value(2, Vector3(0.5, 0.5, 0))
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
		2:
			return VisualShaderNode.PORT_TYPE_VECTOR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "uv"

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return output_vars[0] + " = (%s - %s) * %s + %s;" % [input_vars[0], input_vars[2], input_vars[1], input_vars[2]]
