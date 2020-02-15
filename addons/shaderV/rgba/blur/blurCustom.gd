tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAblurCustom

func _init() -> void:
	set_input_port_default_value(2, -1.0)
	set_input_port_default_value(3, 5)
	set_input_port_default_value(4, 0.001)

func _get_name() -> String:
	return "BlurCustom"

func _get_category() -> String:
	return "RGBA"

func _get_subcategory():
	return "Blur"

func _get_description() -> String:
	return """Custom 8-directional blur with ([amount]*2+1)^2 samples
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
			return "amount"
		4:
			return "offset"

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
vec4 blurWithAmountFunc(sampler2D _tex_b1r_cst, vec2 _uv_b1r_cst, float _l0d_b1r_cst, int _amnt_b1r_cst, float _0ffst_b1r_cst) {
	vec4 _c0l_b1r_cst = vec4(0, 0, 0, 0);
	_amnt_b1r_cst = int(max(min(float(_amnt_b1r_cst), 20.0), 0.0)); // have to do this int() float() shit because of gles2 
																	// max _amnt_b1r_cst is 20 for not to kill PC
	for(int x = -_amnt_b1r_cst; x <= _amnt_b1r_cst; x++) {
		for(int y = -_amnt_b1r_cst; y <= _amnt_b1r_cst; y++) {
			vec2 _c00rd_b1r_cst = _uv_b1r_cst + vec2(float(x), float(y)) * _0ffst_b1r_cst;
			if (_l0d_b1r_cst < 0.0){
				_c0l_b1r_cst += texture(_tex_b1r_cst, _c00rd_b1r_cst);
			}else{
				_c0l_b1r_cst += textureLod(_tex_b1r_cst, _c00rd_b1r_cst, _l0d_b1r_cst);
			}
		}
	}
	int _nmb_ne1ghb0urs_b1r_cst = (_amnt_b1r_cst * 2 + 1) * (_amnt_b1r_cst * 2 + 1);
	_c0l_b1r_cst /= float(_nmb_ne1ghb0urs_b1r_cst);
	return _c0l_b1r_cst;
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return """vec4 %s%s = blurWithAmountFunc(%s, %s.xy, %s, int(%s), %s);
%s = %s%s.rgb;
%s = %s%s.a;""" % [
output_vars[0], output_vars[1], input_vars[0], input_vars[1], input_vars[2], input_vars[3], input_vars[4],
output_vars[0], output_vars[0], output_vars[1],
output_vars[1], output_vars[0], output_vars[1]]
