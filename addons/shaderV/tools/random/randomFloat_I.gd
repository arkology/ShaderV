tool
extends VisualShaderNodeCustom
class_name VisualShaderToolsRandomFloat_I

func _init() -> void:
	set_input_port_default_value(1, 1.0)
	set_input_port_default_value(2, Vector3(0.0, 0.0, 0.0))

func _get_name() -> String:
	return "RandomFloat_I"

func _get_category() -> String:
	return "Tools"

func _get_subcategory() -> String:
	return "Random"

func _get_description() -> String:
	return "Improved version of classic random function. Classic random can produce artifacts. This one - doesn't."

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_input_port_count() -> int:
	return 3

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "scale"
		2:
			return "offset"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
		2:
			return VisualShaderNode.PORT_TYPE_VECTOR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "rnd"

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_global_code(mode: int) -> String:
	return """
highp float randImpr0vedFunc(vec2 _c0_rnd){
	highp float _tmp_a_rnd = 12.9898;
	highp float _tmp_b_rnd = 78.233;
	highp float _tmp_c_rnd = 43758.5453;
	highp float _tmp_dt_rnd = dot(_c0_rnd, vec2(_tmp_a_rnd, _tmp_b_rnd));
	highp float _tmp_sn_rnd = mod(_tmp_dt_rnd, 3.14);
	return fract(sin(_tmp_sn_rnd) * _tmp_c_rnd);
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s = randImpr0vedFunc(%s.xy * %s + %s.xy);" % [
output_vars[0], input_vars[0], input_vars[1], input_vars[2]]
