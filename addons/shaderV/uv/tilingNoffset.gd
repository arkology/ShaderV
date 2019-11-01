tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeUVtilingNoffset

func _get_name():
	return "TilingAndOffset"

func _get_category():
	return "UV"

#func _get_subcategory():
#	return ""

func _get_description():
	return "Tiles UV with given offset"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count():
	return 2

func _get_input_port_name(port):
	match port:
		0:
			return "uv"
		1:
			return "offset"

func _get_input_port_type(port):
	set_input_port_default_value(1, Vector3(0.0, 0.0, 0.0))
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR

func _get_output_port_count():
	return 1

func _get_output_port_name(port):
	return "uv"

func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_global_code(mode):
	return """
vec2 ti1ingN0ffsetFunc(vec2 _uv_tN0, vec2 _offset_tN0){
	return vec2(mod(_uv_tN0.x + _offset_tN0.x, 1.0), mod(_uv_tN0.y + _offset_tN0.y, 1.0));
}
"""

func _get_code(input_vars, output_vars, mode, type):
	return output_vars[0] + " = vec3(ti1ingN0ffsetFunc(%s.xy, %s.xy), 0);" % [input_vars[0], input_vars[1]]
