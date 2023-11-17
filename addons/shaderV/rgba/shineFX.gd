tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAshineFX

func _init() -> void:
	set_input_port_default_value(3, 0.0)
	set_input_port_default_value(4, 0.0)
	set_input_port_default_value(5, 0.0)
	set_input_port_default_value(6, 0.0)
	set_input_port_default_value(7, 0.0)
	set_input_port_default_value(8, 0.0)
	set_input_port_default_value(9, Vector3(1.0, 1.0, 1.0))

func _get_name() -> String:
	return "ShineFX"

func _get_category() -> String:
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return "Adds shine effect in form of line"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 10

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "color"
		2:
			return "alpha"
		3:
			return "location"
		4:
			return "angle(radians)"
		5:
			return "width"
		6:
			return "soft"
		7:
			return "bright"
		8:
			return "gloss"
		9:
			return "shineColor"

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
		4:
			return VisualShaderNode.PORT_TYPE_SCALAR
		5:
			return VisualShaderNode.PORT_TYPE_SCALAR
		6:
			return VisualShaderNode.PORT_TYPE_SCALAR
		7:
			return VisualShaderNode.PORT_TYPE_SCALAR
		8:
			return VisualShaderNode.PORT_TYPE_SCALAR
		9:
			return VisualShaderNode.PORT_TYPE_VECTOR

func _get_output_port_count() -> int:
	return 2

func _get_output_port_name(port: int):
	match port:
		0:
			return "col"
		1:
			return "alpha"

func _get_output_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_global_code(mode: int) -> String:
	var code : String = preload("shineFX.gdshader").code
	code = code.replace("shader_type canvas_item;\n", "").replace("shader_type canvas_item;\r\n", "")
	return code

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	var uv = "UV"
	
	if input_vars[0]:
		uv = input_vars[0]
	
	return """%s = %s;
%s = _shineFunc(vec4(%s, %s), %s.xy, %s, %s, %s, %s, %s, %s, %s).rgb;""" % [
output_vars[1], input_vars[2],
output_vars[0], input_vars[1], input_vars[2], uv, input_vars[3], input_vars[4],
input_vars[5], input_vars[6], input_vars[7], input_vars[8], input_vars[9]]
