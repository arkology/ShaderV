tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAemboss

func _init() -> void:
	set_input_port_default_value(2, -1.0)
	set_input_port_default_value(3, 0.005)
	set_input_port_default_value(4, 1.0)

func _get_name() -> String:
	return "Emboss"

func _get_category() -> String:
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return """Emboss filter.
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
			return "offset"
		4:
			return "contrast"

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
vec4 emb0ssFunc(sampler2D _tex_emb0ss, vec2 _uv_emb0ss, float _lod_emb0ss, vec2 _ofst_emb0ss, float _ctst_emb0ss){
	vec4 col_emb0ss = vec4(0.5, 0.5, 0.5, 0.5);
	if (_lod_emb0ss < 0.0){
		col_emb0ss -= texture(_tex_emb0ss, _uv_emb0ss - _ofst_emb0ss) * _ctst_emb0ss;
		col_emb0ss += texture(_tex_emb0ss, _uv_emb0ss + _ofst_emb0ss) * _ctst_emb0ss;
	}else{
		col_emb0ss -= textureLod(_tex_emb0ss, _uv_emb0ss - _ofst_emb0ss, _lod_emb0ss) * _ctst_emb0ss;
		col_emb0ss += textureLod(_tex_emb0ss, _uv_emb0ss + _ofst_emb0ss, _lod_emb0ss) * _ctst_emb0ss;
	}
	col_emb0ss.rgb = vec3(0.21 * col_emb0ss.r + 0.71 * col_emb0ss.g + 0.07 * col_emb0ss.b);
	return col_emb0ss;
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return """vec4 %s%s = emb0ssFunc(%s, %s.xy, %s, vec2(%s), %s);
%s = %s%s.rgb;
%s = %s%s.a;""" % [
output_vars[0], output_vars[1], input_vars[0], input_vars[1], input_vars[2], input_vars[3], input_vars[4],
output_vars[0], output_vars[0], output_vars[1],
output_vars[1], output_vars[0], output_vars[1]]
