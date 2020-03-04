tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeUVscale

func _init() -> void:
	set_input_port_default_value(1, Vector3(1, 1, 0))
	set_input_port_default_value(2, Vector3(0.5, 0.5, 0))

func _get_name() -> String:
	return "ScaleUV"

func _get_category() -> String:
	return "UV"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return "Scale UV relative to pivot point"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 3

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "scale"
		2:
			return "pivot"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR
		2:
			return VisualShaderNode.PORT_TYPE_VECTOR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "uv"

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s.xy = (%s.xy - %s.xy) * %s.xy + %s.xy;" % [
	output_vars[0], input_vars[0], input_vars[2], input_vars[1], input_vars[2]]
