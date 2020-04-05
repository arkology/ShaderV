tool
extends VisualShaderNodeCustom
class_name VisualShaderToolsRandomFloatGoldenRation

func _init() -> void:
	set_input_port_default_value(0, Vector3(0, 0, 0))
	set_input_port_default_value(1, Vector3(0, 0, 0))
	set_input_port_default_value(2, 0.0)

func _get_name() -> String:
	return "RandomGoldRatio"

func _get_category() -> String:
	return "Tools"

func _get_subcategory() -> String:
	return "Random"

func _get_description() -> String:
	return "Random float based on golden ratio"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_input_port_count() -> int:
	return 3

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "offset"
		2:
			return "seed"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port) -> String:
	return "rand"

func _get_output_port_type(port) -> int:
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_global_code(mode: int) -> String:
	return """
float randomGoldRatioFunc(vec2 _coord_gn, vec2 _scale_gn, float _seed_gn){
	float PHI = 1.6180339887; 
	float PI  = 3.1415926536;
	float SQ2 = 1.4142135624;
	return fract(tan(distance((_coord_gn+_scale_gn)*(_seed_gn+PHI), vec2(PHI, PI)))*SQ2);
}
"""

func _get_code(input_vars, output_vars, mode, type):
	return "%s = randomGoldRatioFunc(%s.xy, %s.xy, %s)" % [
output_vars[0], input_vars[0], input_vars[1], input_vars[2]]
