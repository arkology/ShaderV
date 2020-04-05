tool
extends VisualShaderNodeCustom
class_name VisualShaderToolsCartesianToSpherical

func _init() -> void:
	set_input_port_default_value(0, Vector3(1.0, 1.0, 1.0))

func _get_name() -> String:
	return "CartesianToSpherical"

func _get_category() -> String:
	return "Tools"

func _get_subcategory():
	return "TransformCoordinates"

func _get_description() -> String:
	return "Cartesian (x, y, z) -> Spherical (r, theta, phi)"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 1

func _get_input_port_name(port: int) -> String:
	return "cartesian"

func _get_input_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR
	

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port ) -> String:
	return "spherical"

func _get_output_port_type(port) -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_global_code(mode: int) -> String:
	return """
vec3 cartesianToSphericalFunc(vec3 _cartesian_vec3){
//	(x, y, z) -> (r, theta, phi)
	return vec3(length(_cartesian_vec3),
				atan(_cartesian_vec3.y / _cartesian_vec3.x),
				atan(length(_cartesian_vec3.xy)/ _cartesian_vec3.z));
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s = cartesianToSphericalFunc(%s);" % [output_vars[0], input_vars[0]]

