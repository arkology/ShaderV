tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeUVswirl

func _init() -> void:
	set_input_port_default_value(1, Vector3(0.5, 0.5, 0.0))
	set_input_port_default_value(2, 0.0)
	set_input_port_default_value(3, 0.0)

func _get_name() -> String:
	return "SwirlUV"

func _get_category() -> String:
	return "UV"

func _get_subcategory() -> String:
	return "Animated"

func _get_description() -> String:
	return "Swirl UV effect"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 4

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "pivot"
		2:
			return "strength"
		3:
			return "sin_time"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR
		3:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "uv"

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_global_code(mode: int) -> String:
	var code : String = preload("swirlUV.gdshader").code
	code = code.replace("shader_type canvas_item;\n", "").replace("shader_type canvas_item;\r\n", "")
	return code

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	var uv = "UV"
	
	if input_vars[0]:
		uv = input_vars[0]
	
	return "%s.xy = _swirlUVFunc(%s.xy, %s, %s.xy, %s);" % [
			output_vars[0], uv, input_vars[3], input_vars[1], input_vars[2]]
