tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAglowEmpty

func _init() -> void:
	set_input_port_default_value(2, -1.0)
	set_input_port_default_value(3, 1.0)
	set_input_port_default_value(4, 1.0)
	set_input_port_default_value(5, 1.0)
	set_input_port_default_value(6, Vector3(1.0, 1.0, 1.0))
	set_input_port_default_value(7, 1.0)

func _get_name() -> String:
	return "GlowEmpty"

func _get_category() -> String:
	return "RGBA"

func _get_subcategory():
	return "Glow"

func _get_description() -> String:
	return "Combination of InnerGlowEmpty and OuterGlowEmpty"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 8

func _get_input_port_name(port: int):
	match port:
		0:
			return "sampler2D"
		1:
			return "uv"
		2:
			return "lod"
		3:
			return "size"
		4:
			return "inIntensity"
		5:
			return "outIntensity"
		6:
			return "color"
		7:
			return "alpha"

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
vec4 inoutGl0wEmptyFunc(sampler2D _samp_1ngl0wEmpt, vec2 _uv_1ngl0wEmpt, float _l0d_gl0wEmpt,
float _rad_in0ut_Empty, float _intens_inner_gl0wEmpt, float _intens_outer_gl0wEmpt, vec4 _c0l_1ngl0wEmpt){
	_rad_in0ut_Empty = abs(_rad_in0ut_Empty);
	
	vec4 _c01r_orig_gl0w = vec4(0.0);
	float _a1pha_gl0w_1nv = 0.0;
	float _a1pha_gl0w_blured = 0.0;
	int gl0w_amount = 3;
	
	if (_l0d_gl0wEmpt < 0.0)
		_c01r_orig_gl0w = texture(_samp_1ngl0wEmpt, _uv_1ngl0wEmpt);
	else
		_c01r_orig_gl0w = textureLod(_samp_1ngl0wEmpt, _uv_1ngl0wEmpt, _l0d_gl0wEmpt);
	
	gl0w_amount = int(min(_rad_in0ut_Empty + 7.0, 14.0));
	for(int x = - gl0w_amount; x <= gl0w_amount; x++) {
		for(int y = - gl0w_amount; y <= gl0w_amount; y++) {
			vec2 _c00rd_b1r_cst = _uv_1ngl0wEmpt + vec2(float(x), float(y)) * _rad_in0ut_Empty * 0.01;
			_a1pha_gl0w_blured += textureLod(_samp_1ngl0wEmpt, _c00rd_b1r_cst, 0.0).a;
		}
	}
	int _nmb_ne1ghb0urs_b1r_cst = (gl0w_amount * 2 + 1) * (gl0w_amount * 2 + 1);
	_a1pha_gl0w_blured /= float(_nmb_ne1ghb0urs_b1r_cst);
	
	_a1pha_gl0w_1nv = _a1pha_gl0w_blured;
	_a1pha_gl0w_1nv *= (1.0 - _c01r_orig_gl0w.a);
	
	float in_a1pha_gl0w_1nv = 1.0 - _a1pha_gl0w_blured;
	in_a1pha_gl0w_1nv *= _c01r_orig_gl0w.a;
	
	if (_a1pha_gl0w_1nv > 0.0)
		_a1pha_gl0w_1nv *= (_intens_outer_gl0wEmpt + 1.0);
	
	if (in_a1pha_gl0w_1nv > 0.0)
		in_a1pha_gl0w_1nv *= (_intens_inner_gl0wEmpt + 1.0);
	
	return vec4(_c0l_1ngl0wEmpt.rgb, (_a1pha_gl0w_1nv + in_a1pha_gl0w_1nv) * _c0l_1ngl0wEmpt.a);
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return """vec4 %s%s = inoutGl0wEmptyFunc(%s, %s.xy, %s, %s, %s, %s, vec4(%s, %s));
%s = %s%s.rgb;
%s = %s%s.a;""" % [
output_vars[0], output_vars[1], input_vars[0], input_vars[1], input_vars[2], input_vars[3],
								input_vars[4], input_vars[5], input_vars[6], input_vars[7],
output_vars[0], output_vars[0], output_vars[1],
output_vars[1], output_vars[0], output_vars[1]]
