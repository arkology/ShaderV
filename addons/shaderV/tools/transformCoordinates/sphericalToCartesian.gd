tool
extends VisualShaderNodeCustom
class_name VisualShaderToolsSphericalToCartesian

func _init() -> void:
	set_input_port_default_value(0, Vector3(1.0, 1.0, 1.0))

func _get_name() -> String:
	return "SphericalToCartesian"

func _get_category() -> String:
	return "Tools"

func _get_subcategory():
	return "TransformCoordinates"

func _get_description() -> String:
	return "Spherical (r, theta, phi) -> Cartesian (x, y, z)"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 1

func _get_input_port_name(port: int) -> String:
	return "spherical"

func _get_input_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR
	

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port ) -> String:
	return "cartesian"

func _get_output_port_type(port) -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_global_code(mode: int) -> String:
	return """
vec3 sphericalToCartesianFunc(vec3 _spherical_vec3){
//	(r, theta, phi) -> (x, y, z)
	return vec3(_spherical_vec3.x * sin(_spherical_vec3.z) * cos(_spherical_vec3.y),
				_spherical_vec3.x * sin(_spherical_vec3.z) * sin(_spherical_vec3.y),
				_spherical_vec3.x * cos(_spherical_vec3.z));
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s = sphericalToCartesianFunc(%s);" % [output_vars[0], input_vars[0]]

