tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeUVflip

func _init() -> void:
	set_input_port_default_value(1, false)
	set_input_port_default_value(2, false)

func _get_name() -> String:
	return "FlipUV"

func _get_category() -> String:
	return "UV"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return "Flip UV horizontal or vertical"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 3

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "vert"
		2:
			return "hor"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_BOOLEAN
		2:
			return VisualShaderNode.PORT_TYPE_BOOLEAN

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "uv"

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return output_vars[0] + " = vec3(mix(%s.x, 1.0 - %s.x, float(%s)), mix(%s.y, 1.0 - %s.y, float(%s)), 0);" % [
	input_vars[0], input_vars[0], input_vars[1], input_vars[0], input_vars[0], input_vars[2]]
