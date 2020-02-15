tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAtonemap

func _init() -> void:
	set_input_port_default_value(1, 0.0)
	set_input_port_default_value(2, 1.0)

func _get_name() -> String:
	return "Tonemap"

func _get_category() -> String:
	return "RGBA"

#func _get_subcategory():
#	return ""

#func _get_description() -> String:
#	return ""

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 3

func _get_input_port_name(port: int):
	match port:
		0:
			return "color"
		1:
			return "exposure"
		2:
			return "gamma"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "col"

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_global_code(mode: int) -> String:
	return """
vec3 t0nemapFunc(vec3 _c0l0r_t0nemap, float _exposure_t0nemap, float _gamma_t0nemap){
	_c0l0r_t0nemap.rgb *= pow(2.0, _exposure_t0nemap);
	_c0l0r_t0nemap.rgb = pow(_c0l0r_t0nemap.rgb, vec3(_gamma_t0nemap));
	return _c0l0r_t0nemap;
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s = t0nemapFunc(%s, %s, %s);" % [
output_vars[0], input_vars[0], input_vars[1], input_vars[2]]
