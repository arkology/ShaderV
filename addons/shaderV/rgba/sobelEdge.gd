@tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAsobelEdge

func _init():
	set_input_port_default_value(2, -1.0)
	set_input_port_default_value(3, 0.001)
	set_input_port_default_value(4, false)
	set_input_port_default_value(5, false)

func _get_name() -> String:
	return "SobelEdge"

func _get_category() -> String:
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return """Sobel edge filter. Returns detected edges as scalar.
'scharr' controls if Scharr or Sobel operator is used.
Note: negative lod => detect lod automatically"""

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_SCALAR

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
			return "offset"
		4:
			return "preconvertToGray"
		5:
			return "scharr"

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
			return VisualShaderNode.PORT_TYPE_BOOLEAN
		5:
			return VisualShaderNode.PORT_TYPE_BOOLEAN

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "edges"

func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_global_code(mode):
	var path = self.get_script().get_path().get_base_dir()
	return '#include "' + path + '/sobelEdge.gdshaderinc"'

func _get_code(input_vars, output_vars, mode, type):
	var texture = "TEXTURE"
	var uv = "UV"
	
	if input_vars[0]:
		texture = input_vars[0]
	if input_vars[1]:
		uv = input_vars[1]
	
	return "%s = _sobelEdgeFunc(%s, %s.xy, %s, %s, %s, %s);" % [
output_vars[0], texture, uv, input_vars[2], input_vars[3], input_vars[4], input_vars[5]]
