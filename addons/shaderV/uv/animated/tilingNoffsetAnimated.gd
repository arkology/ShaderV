@tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeUVtilingNoffsetAnimated

func _init():
	set_input_port_default_value(1, Vector3(0.0, 0.0, 0.0))
	set_input_port_default_value(2, 0.0)

func _get_name() -> String:
	return "TilingAndOffsetUVAnimated"

func _get_category() -> String:
	return "UV"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return "Animated UV tiling with given [offset] speed"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_input_port_count() -> int:
	return 3

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "offset"
		2:
			return "time"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "uv"

func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_VECTOR_2D

func _get_global_code(mode):
	var path = self.get_script().get_path().get_base_dir()
	return '#include "' + path + '/tilingNoffsetAnimated.gdshaderinc"'

func _get_code(input_vars, output_vars, mode, type):
	var uv = "UV"
	
	if input_vars[0]:
		uv = input_vars[0]
	
	return "%s.xy = _tilingNoffsetAnimatedFunc(%s.xy, %s, %s.xy);" % [
			output_vars[0], uv, input_vars[2], input_vars[1]]
