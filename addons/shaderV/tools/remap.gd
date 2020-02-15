tool
extends VisualShaderNodeCustom
class_name VisualShaderToolsRemap

func _init() -> void:
	set_input_port_default_value(1, 0.0)
	set_input_port_default_value(2, 1.0)
	set_input_port_default_value(3, -1.0)
	set_input_port_default_value(4, 1.0)

func _get_name() -> String:
	return "Remap"

func _get_category() -> String:
	return "Tools"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return "Remaps input value from ( [inMin], [inMax] ) range to ( [outMin], [outMax] )"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 5

func _get_input_port_name(port: int):
	match port:
		0:
			return "input"
		1:
			return "inMin"
		2:
			return "inMin"
		3:
			return "outMin"
		4:
			return "outMax"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR
		3:
			return VisualShaderNode.PORT_TYPE_SCALAR
		4:
			return VisualShaderNode.PORT_TYPE_SCALAR
	

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port ) -> String:
	return "out"

func _get_output_port_type(port) -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_global_code(mode: int) -> String:
	return """
vec3 remapFunc(vec3 _inpt_r4p, vec2 _fr0m_r4p, vec2 _t0_r4p){
	return _t0_r4p.x + ((_inpt_r4p - _fr0m_r4p.x) * (_t0_r4p.y - _t0_r4p.x)) / (_fr0m_r4p.y - _fr0m_r4p.x);
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return output_vars[0] + " = remapFunc(%s, vec2(%s, %s), vec2(%s, %s));" % [
	input_vars[0], input_vars[1], input_vars[2], input_vars[3], input_vars[4]]




