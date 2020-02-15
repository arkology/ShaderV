tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAchromaticAberration

func _init() -> void:
	set_input_port_default_value(2, -1.0)
	set_input_port_default_value(3, 0.05)
	set_input_port_default_value(4, 0.0)

func _get_name() -> String:
	return "ChromaticAberration"

func _get_category() -> String:
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return """Basic Chromatic Aberration with red and blue channels offset
Note: negative lod => detect lod automatically"""

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 5

func _get_input_port_name(port: int):
	match port:
		0:
			return "sampler2D"
		1:
			return "uv"
		2:
			return "lod"
		3:
			return "amountX"
		4:
			return "amountY"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_SAMPLER
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR
		3:
			return VisualShaderNode.PORT_TYPE_SCALAR
		4:
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
vec4 chr0maticAberrati0nFunc(sampler2D _texture_chr_aberrat1on, vec2 _uv_chr_aberrat1on, vec3 _values_chr_aberrat1on){
	vec4 _c0l_chr_aberrat1on = vec4(0.0);
	if (_values_chr_aberrat1on.z < 0.0){
		_c0l_chr_aberrat1on.r = texture(_texture_chr_aberrat1on, _uv_chr_aberrat1on + _values_chr_aberrat1on.xy).r;
		_c0l_chr_aberrat1on.g = texture(_texture_chr_aberrat1on, _uv_chr_aberrat1on).g;
		_c0l_chr_aberrat1on.b = texture(_texture_chr_aberrat1on, _uv_chr_aberrat1on - _values_chr_aberrat1on.xy).b;
		_c0l_chr_aberrat1on.a = texture(_texture_chr_aberrat1on, _uv_chr_aberrat1on).a;
	}else{
		_c0l_chr_aberrat1on.r = textureLod(_texture_chr_aberrat1on, _uv_chr_aberrat1on +
											_values_chr_aberrat1on.xy, _values_chr_aberrat1on.z).r;
		_c0l_chr_aberrat1on.g = textureLod(_texture_chr_aberrat1on, _uv_chr_aberrat1on, _values_chr_aberrat1on.z).g;
		_c0l_chr_aberrat1on.b = textureLod(_texture_chr_aberrat1on, _uv_chr_aberrat1on -
											_values_chr_aberrat1on.xy, _values_chr_aberrat1on.z).b;
		_c0l_chr_aberrat1on.a = textureLod(_texture_chr_aberrat1on, _uv_chr_aberrat1on, _values_chr_aberrat1on.z).a;
	}
	return _c0l_chr_aberrat1on;
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return """vec4 %s%s = chr0maticAberrati0nFunc(%s, %s.xy, vec3(%s, %s, %s));
%s = %s%s.rgb;
%s = %s%s.a;""" % [
output_vars[0], output_vars[1], input_vars[0], input_vars[1], input_vars[3], input_vars[4], input_vars[2],
output_vars[0], output_vars[0], output_vars[1],
output_vars[1], output_vars[0], output_vars[1]]
