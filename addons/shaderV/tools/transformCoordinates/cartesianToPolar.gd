tool
extends VisualShaderNodeCustom
class_name VisualShaderToolsCartesianToPolar

func _init() -> void:
	set_input_port_default_value(0, Vector3(1.0, 1.0, 0.0))

func _get_name() -> String:
	return "CartesianToPolar"

func _get_category() -> String:
	return "Tools"

func _get_subcategory():
	return "TransformCoordinates"

func _get_description() -> String:
	return "Cartesian (x, y) -> Polar (r, theta)"

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
	return "polar"

func _get_output_port_type(port) -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_global_code(mode: int) -> String:
	return """
vec2 cartesianToPolarFunc(vec2 _cartesian_vec2){
//	(x, y) -> (r, theta)
	return vec2(length(_cartesian_vec2),
				atan(_cartesian_vec2.y / _cartesian_vec2.x));
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s.xy = cartesianToPolarFunc(%s.xy);" % [output_vars[0], input_vars[0]]

