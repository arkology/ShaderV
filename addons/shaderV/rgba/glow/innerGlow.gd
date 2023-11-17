@tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAinnerGlow

func _init():
	set_input_port_default_value(2, -1.0)
	set_input_port_default_value(3, 1.0)
	set_input_port_default_value(4, 1.0)
	set_input_port_default_value(5, Vector3(1.0, 1.0, 1.0))
	set_input_port_default_value(6, 1.0)

func _get_name() -> String:
	return "InnerGlow"

func _get_category() -> String:
	return "RGBA"

func _get_subcategory():
	return "Glow"

func _get_description() -> String:
	return "Adds inner glow to color. Color should have alpha < 1.0 to find contours"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_input_port_count() -> int:
	return 7

func _get_input_port_name(port: int):
	match port:
		0:
			return "sampler2D"
		1:
			return "uv"
		2:
			return "lod"
		3:
			return "size"
		4:
			return "intensity"
		5:
			return "color"
		6:
			return "alpha"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_SAMPLER
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR
		3:
			return VisualShaderNode.PORT_TYPE_SCALAR
		4:
			return VisualShaderNode.PORT_TYPE_SCALAR
		5:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		6:
			return VisualShaderNode.PORT_TYPE_SCALAR

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
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_global_code(mode):
	var path = self.get_script().get_path().get_base_dir()
	return '#include "' + path + '/innerGlow.gdshaderinc"'

func _get_code(input_vars, output_vars, mode, type):
	var texture = "TEXTURE"
	var uv = "UV"
	
	if input_vars[0]:
		texture = input_vars[0]
	if input_vars[1]:
		uv = input_vars[1]
	
	return """vec4 %s%s = _innerGlowFunc(%s, %s.xy, %s, %s, %s, vec4(%s, %s));
%s = %s%s.rgb;
%s = %s%s.a;""" % [
output_vars[0], output_vars[1], texture, uv, input_vars[2], input_vars[3], input_vars[4], input_vars[5], input_vars[6],
output_vars[0], output_vars[0], output_vars[1],
output_vars[1], output_vars[0], output_vars[1]]
