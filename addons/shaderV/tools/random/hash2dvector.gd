tool
extends VisualShaderNodeCustom
class_name VisualShaderToolsHash2Dvec

func _get_name() -> String:
	return "HashRandom2dVec"

func _get_category() -> String:
	return "Tools"

func _get_subcategory() -> String:
	return "Random"

func _get_description() -> String:
	return "Hash func with vector input and vector output"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 1

func _get_input_port_name(port: int) -> String:
	return "in"

func _get_input_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port ) -> String:
	return "vec"

func _get_output_port_type(port) -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_global_code(mode: int) -> String:
	return """
vec2 hash2v(vec2 co) {
	float _tmp_h = dot(co, vec2(12.9898, 78.233));
	return fract(vec2(sin(_tmp_h), cos(_tmp_h)) * 43758.5453) * 2.0 - 1.0;
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s.xy = hash2v(%s.xy);" % [output_vars[0], input_vars[0]]




