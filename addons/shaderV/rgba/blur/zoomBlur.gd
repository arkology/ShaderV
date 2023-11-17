@tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAzoomBlur

func _init():
	set_input_port_default_value(2, -1.0)
	set_input_port_default_value(3, Vector3(0.5, 0.5, 0.0))
	set_input_port_default_value(4, 20)
	set_input_port_default_value(5, 0.005)

func _get_name() -> String:
	return "ZoomBlur"

func _get_category() -> String:
	return "RGBA"

func _get_subcategory():
	return "Blur"

func _get_description() -> String:
	return """Zoom blur using [amount] samples
Note: negative lod => detect lod automatically"""

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_input_port_count() -> int:
	return 6

func _get_input_port_name(port: int):
	match port:
		0:
			return "sampler2D"
		1:
			return "uv"
		2:
			return "lod"
		3:
			return "pivot"
		4:
			return "amount"
		5:
			return "length"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_SAMPLER
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR
		3:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		4:
			return VisualShaderNode.PORT_TYPE_SCALAR
		5:
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
	return '#include "' + path + '/zoomBlur.gdshaderinc"'

func _get_code(input_vars, output_vars, mode, type):
	var texture = "TEXTURE"
	var uv = "UV"
	
	if input_vars[0]:
		texture = input_vars[0]
	if input_vars[1]:
		uv = input_vars[1]
	
	return """vec4 %s%s = _zoomBlurFunc(%s, %s.xy, int(%s), %s.xy, %s, %s);
%s = %s%s.rgb;
%s = %s%s.a;""" % [
			output_vars[0], output_vars[1], texture, uv, input_vars[4], input_vars[3], input_vars[5], input_vars[2],
			output_vars[0], output_vars[0], output_vars[1],
			output_vars[1], output_vars[0], output_vars[1]]
