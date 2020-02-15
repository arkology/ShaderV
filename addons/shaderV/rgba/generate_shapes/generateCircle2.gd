tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAcreateCircle2

func _init() -> void:
	set_input_port_default_value(1, Vector3(0.5, 0.5, 0))
	set_input_port_default_value(2, Vector3(1.0, 1.0, 0.0))
	set_input_port_default_value(3, 0.0)
	set_input_port_default_value(4, 0.5)
	set_input_port_default_value(5, 0.5)
	set_input_port_default_value(6, Vector3(1.0, 1.0, 1.0))
	set_input_port_default_value(7, 1.0)

func _get_name() -> String:
	return "CircleShape2"

func _get_category() -> String:
	return "RGBA"

func _get_subcategory():
	return "Shapes"

func _get_description() -> String:
	return "Circle creation with adjusted position, scale, radius inner/outer width, and color"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 8

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "pos"
		2:
			return "scale"
		3:
			return "radius"
		4:
			return "inWidth"
		5:
			return "outWidth"
		6:
			return "color"
		7:
			return "alpha"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR
		2:
			return VisualShaderNode.PORT_TYPE_VECTOR
		3:
			return VisualShaderNode.PORT_TYPE_SCALAR
		4:
			return VisualShaderNode.PORT_TYPE_SCALAR
		5:
			return VisualShaderNode.PORT_TYPE_SCALAR
		6:
			return VisualShaderNode.PORT_TYPE_VECTOR
		7:
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
vec4 generateCircle2Func(vec2 _uv_gc2, vec2 _p0s_gc2, vec2 _sca1e_gc2, float _rad_gc2,
						 float _b0rdIn_gc2, float _b0rdOut_gc2, vec4 _c0l_gc2){
	float _dst_gc2 = length((_uv_gc2 - _p0s_gc2) * _sca1e_gc2);
	_c0l_gc2.a *= smoothstep(_rad_gc2 - _b0rdIn_gc2, _rad_gc2, _dst_gc2) 
				 - smoothstep(_rad_gc2, _rad_gc2 + _b0rdOut_gc2, _dst_gc2);
	return _c0l_gc2;
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return """vec4 %s%s = generateCircle2Func(%s.xy, %s.xy, %s.xy, %s, %s, %s, vec4(%s, %s));
%s = %s%s.rgb;
%s = %s%s.a;""" % [
output_vars[0], output_vars[1], input_vars[0], input_vars[1], input_vars[2], input_vars[3],
								input_vars[4], input_vars[5], input_vars[6], input_vars[7],
output_vars[0], output_vars[0], output_vars[1],
output_vars[1], output_vars[0], output_vars[1]]
