tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAshineFX

func _init() -> void:
	set_input_port_default_value(3, 0.0)
	set_input_port_default_value(4, 0.0)
	set_input_port_default_value(5, 0.0)
	set_input_port_default_value(6, 0.0)
	set_input_port_default_value(7, 0.0)
	set_input_port_default_value(8, 0.0)
	set_input_port_default_value(9, Vector3(1.0, 1.0, 1.0))

func _get_name() -> String:
	return "ShineFX"

func _get_category() -> String:
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return "Adds shine effect in form of line"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 10

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "color"
		2:
			return "alpha"
		3:
			return "location"
		4:
			return "angle(radians)"
		5:
			return "width"
		6:
			return "soft"
		7:
			return "bright"
		8:
			return "gloss"
		9:
			return "shineColor"

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
			return VisualShaderNode.PORT_TYPE_SCALAR
		8:
			return VisualShaderNode.PORT_TYPE_SCALAR
		9:
			return VisualShaderNode.PORT_TYPE_VECTOR

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
vec4 shineFunc(vec4 _color_sh1ne, vec2 _uv_sh1ne, float _loc_sh1ne, float _rot_sh1ne, float _width_sh1ne, float _soft_sh1ne, float _bright_sh1ne, float _gloss_sh1ne, vec3 _shine_color_sh1ne){
	vec2 _angle_sh1ne = vec2(cos(_rot_sh1ne), sin(_rot_sh1ne));
	float _norm_pos_sh1ne = dot(_uv_sh1ne, _angle_sh1ne);
	float _normal_sh1ne = 1.0 - min(max(abs((_norm_pos_sh1ne - _loc_sh1ne) / _width_sh1ne), 0.0), 1.0);
	float _shine_power_sh1ne = smoothstep(0.0, _soft_sh1ne * 2.0, _normal_sh1ne);
	vec3 _reflect_color_sh1ne = mix(vec3(1.0), _color_sh1ne.rgb * 10.0, _gloss_sh1ne);
	_color_sh1ne.rgb += _color_sh1ne.a * _shine_power_sh1ne * _bright_sh1ne * _reflect_color_sh1ne * _shine_color_sh1ne.rgb;
	return min(max(_color_sh1ne, vec4(0.0)), vec4(1.0));
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return """%s = %s;
%s = shineFunc(vec4(%s, %s), %s.xy, %s, %s, %s, %s, %s, %s, %s).rgb;""" % [
output_vars[1], input_vars[2],
output_vars[0], input_vars[1], input_vars[2], input_vars[0], input_vars[3], input_vars[4],
input_vars[5], input_vars[6], input_vars[7], input_vars[8], input_vars[9]]
