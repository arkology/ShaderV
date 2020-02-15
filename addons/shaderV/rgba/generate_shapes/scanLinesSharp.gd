tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAscanLinesSharp

func _init() -> void:
	set_input_port_default_value(1, 21)
	set_input_port_default_value(2, 0.5)
	set_input_port_default_value(3, 1)
	set_input_port_default_value(4, 0)
	set_input_port_default_value(5, Vector3(1.0, 1.0, 1.0))
	set_input_port_default_value(6, 1)

func _get_name() -> String:
	return "ScanLinesSharpShape"

func _get_category() -> String:
	return "RGBA"

func _get_subcategory():
	return "Shapes"

func _get_description() -> String:
	return "Sharp moving scanlines"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 7

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "amount"
		2:
			return "fill"
		3:
			return "speed"
		4:
			return "time"
		5:
			return "color"
		6:
			return "alpha"

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
		5:
			return VisualShaderNode.PORT_TYPE_VECTOR
		6:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count() -> int:
	return 2

func _get_output_port_name(port: int):
	match port:
		0:
			return "col"
		1:
			return "alpha"

func _get_output_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_global_code(mode: int) -> String:
	return """
float scanL1nesSharpFunc(vec2 _uv_scL1Shrp, float _am0nt_scL1Shrp, float _f1ll_scL1Shrp, float _spd_scL1Shrp, float _t1me_scL1Shrp) {
	return step(fract(_uv_scL1Shrp.y * _am0nt_scL1Shrp + _t1me_scL1Shrp * _spd_scL1Shrp), _f1ll_scL1Shrp);
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return """%s = %s;
%s = scanL1nesSharpFunc(%s.xy, %s, %s, %s, %s) * %s;""" % [
output_vars[0], input_vars[5],
output_vars[1], input_vars[0], input_vars[1], input_vars[2], input_vars[3], input_vars[4], input_vars[6]]
