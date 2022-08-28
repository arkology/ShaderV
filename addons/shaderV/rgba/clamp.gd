tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeUVclampAlpha

func _get_name() -> String:
	return "ClampAlphaBorder"

func _get_category() -> String:
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return "Clamp alpha to border vec4(0, 0, 1, 1)"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_input_port_count() -> int:
	return 2

func _get_input_port_name(port: int):
	match port:
		0:
			return "alpha"
		1:
			return "uv"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_SCALAR
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "alpha"

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_global_code(mode: int) -> String:
	var code : String = preload("clamp.gdshader").code
	code = code.replace("shader_type canvas_item;\n", "")
	return code

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	var texture = "TEXTURE"
	var uv = "UV"
	
	if input_vars[1]:
		uv = input_vars[1]
	
	return output_vars[0] + " = _clampAlphaBorderFunc(%s, (%s).xy);" % [input_vars[0], uv]
