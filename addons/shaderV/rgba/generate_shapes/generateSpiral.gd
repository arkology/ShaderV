tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAcreateSpiral

func _init() -> void:
	set_input_port_default_value(1, Vector3(0.5, 0.5, 0))
	set_input_port_default_value(2, 70.0)
	set_input_port_default_value(3, 1.0)
	set_input_port_default_value(4, 1.0)
	set_input_port_default_value(5, 0.0)
	set_input_port_default_value(6, 0.0)
	set_input_port_default_value(7, Vector3(1.0, 1.0, 1.0))
	set_input_port_default_value(8, 1.0)

func _get_name() -> String:
	return "SpiralShape"

func _get_category() -> String:
	return "RGBA"

func _get_subcategory():
	return "Shapes"

func _get_description() -> String:
	return "Spiral creation with adjusted position, size, linesAmount, softness, speed and color"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 9

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "pivot"
		2:
			return "size"
		3:
			return "linesAmount"
		4:
			return "softness"
		5:
			return "speed"
		6:
			return "time"
		7:
			return "color"
		8:
			return "alpha"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR
		3:
			return VisualShaderNode.PORT_TYPE_SCALAR
		4:
			return VisualShaderNode.PORT_TYPE_SCALAR
		5:
			return VisualShaderNode.PORT_TYPE_SCALAR
		6:
			return VisualShaderNode.PORT_TYPE_SCALAR
		7:
			return VisualShaderNode.PORT_TYPE_VECTOR
		8:
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
vec4 generateSp1ralFunc(vec2 _uv_genSp1r, vec2 _p1v0t_genSp1r, float _s1ze_genSp1r, float _l1neAmnt_genSp1r,
						float _spd_genSp1r, float _s0ft_genSp1r, float _t1me_genSp1r, vec4 _c0l_genSp1r){
	_uv_genSp1r -= _p1v0t_genSp1r;
	float _va1ue_genSp1r = 1.0 - sin(length(_uv_genSp1r) * _s1ze_genSp1r +
					floor(_l1neAmnt_genSp1r) * atan(_uv_genSp1r.x, _uv_genSp1r.y) +
					_t1me_genSp1r * _spd_genSp1r ) / _s0ft_genSp1r;
	return vec4(_c0l_genSp1r.rgb, _c0l_genSp1r.a * _va1ue_genSp1r);
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return """vec4 %s%s = generateSp1ralFunc(%s.xy, %s.xy, %s, %s, %s, %s, %s, vec4(%s, %s));
%s = %s%s.rgb;
%s = %s%s.a;""" % [
output_vars[0], output_vars[1], input_vars[0], input_vars[1], input_vars[2], input_vars[3], input_vars[5],
								input_vars[4], input_vars[6], input_vars[7], input_vars[8],
output_vars[0], output_vars[0], output_vars[1],
output_vars[1], output_vars[0], output_vars[1]]
