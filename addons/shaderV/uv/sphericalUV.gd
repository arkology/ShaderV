tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeUVspherical

func _init() -> void:
	set_input_port_default_value(1, Vector3(1.0, 1.0, 0.0))
	set_input_port_default_value(2, Vector3(0.0, 0.0, 0.0))
	set_input_port_default_value(3, Vector3(0.5, 0.5, 0.0))
	set_input_port_default_value(4, Vector3(0.0, 0.0, 0.0))

func _get_name() -> String:
	return "SphericalUV"

func _get_category() -> String:
	return "UV"

#func _get_subcategory() -> String:
#	return ""

func _get_description() -> String:
	return "Makes UV look like a sphere. Can be used to make 2d planets"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 5

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "radius"
		2:
			return "spin"
		3:
			return "position"
		4:
			return "local position"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR
		2:
			return VisualShaderNode.PORT_TYPE_VECTOR
		3:
			return VisualShaderNode.PORT_TYPE_VECTOR
		4:
			return VisualShaderNode.PORT_TYPE_VECTOR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "uv"

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_global_code(mode: int) -> String:
	return """
vec2 sphericalFunc(vec2 _uv_shprc1, vec2 _p0s_shprc1, vec2 _rad_shprc1, vec2 _sp1n_shprc1, vec2 _l0c_p0s_shprc1){
	vec2 _temp_p = (_uv_shprc1 - _p0s_shprc1) * 2.0;
	float _temp_rad = length((_temp_p - _l0c_p0s_shprc1) * _rad_shprc1) + 0.0001;
	float _temp_f = (1.0 - sqrt(1.0 - _temp_rad)) / _temp_rad;
	return mod(vec2((_temp_p.x * 0.5 * _temp_f + _sp1n_shprc1.x) + 0.5,
					(_temp_p.y * 0.5 * _temp_f + _sp1n_shprc1.y) + 0.5), vec2(1.0));
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s.xy = sphericalFunc(%s.xy, %s.xy, %s.xy, %s.xy, %s.xy);" % [
output_vars[0], input_vars[0], input_vars[3], input_vars[1], input_vars[2], input_vars[4]]
