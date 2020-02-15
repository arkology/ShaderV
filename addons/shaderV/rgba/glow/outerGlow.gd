tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAouterGlow

func _init() -> void:
	set_input_port_default_value(2, -1.0)
	set_input_port_default_value(3, 1.0)
	set_input_port_default_value(4, 1.0)
	set_input_port_default_value(5, Vector3(1.0, 1.0, 1.0))
	set_input_port_default_value(6, 1.0)

func _get_name() -> String:
	return "OuterGlow"

func _get_category() -> String:
	return "RGBA"

func _get_subcategory():
	return "Glow"

func _get_description() -> String:
	return "Adds outer glow to color. Color should have alpha < 1.0 to find contours"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 7

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
			return "intensity"
		5:
			return "color"
		6:
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
vec4 outerGl0wFunc(sampler2D _samp_1ngl0w, vec2 _uv_1ngl0w, float _l0d_1ngl0w, float _rad_1ngl0w, float _1ntns_1ngl0w, vec4 _c0l_1ngl0w){
	_rad_1ngl0w = abs(_rad_1ngl0w);
	
	vec4 _c01r_1ngl0w = vec4(0.0);
	float _a1pha_1nv = 0.0;
	float _a1pha_1ngl0w_b1 = 0.0;
	int _am0nt_1ngl0w = 3;
	
	if (_l0d_1ngl0w < 0.0)
		_c01r_1ngl0w = texture(_samp_1ngl0w, _uv_1ngl0w);
	else
		_c01r_1ngl0w = textureLod(_samp_1ngl0w, _uv_1ngl0w, _l0d_1ngl0w);
	
	_am0nt_1ngl0w = int(min(_rad_1ngl0w + 7.0, 14.0));
	for(int x = - _am0nt_1ngl0w; x <= _am0nt_1ngl0w; x++) {
		for(int y = - _am0nt_1ngl0w; y <= _am0nt_1ngl0w; y++) {
			vec2 _c00rd_b1r_cst = _uv_1ngl0w + vec2(float(x), float(y)) * _rad_1ngl0w * 0.01;
			_a1pha_1ngl0w_b1 += textureLod(_samp_1ngl0w, _c00rd_b1r_cst, 0.0).a;
		}
	}
	int _nmb_ne1ghb0urs_b1r_cst = (_am0nt_1ngl0w * 2 + 1) * (_am0nt_1ngl0w * 2 + 1);
	_a1pha_1ngl0w_b1 /= float(_nmb_ne1ghb0urs_b1r_cst);
	
	_a1pha_1nv = _a1pha_1ngl0w_b1; // inversion
	_a1pha_1nv *= (1.0 - _c01r_1ngl0w.a); // masking
	
	if (_a1pha_1nv > 0.0)
		_a1pha_1nv *= (_1ntns_1ngl0w + 1.0);
	
	vec4 _gl0w_c0l_result = vec4(_c0l_1ngl0w.rgb, _a1pha_1nv * _c0l_1ngl0w.a);
	return mix(_gl0w_c0l_result, _c01r_1ngl0w, _c01r_1ngl0w.a);
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return """vec4 %s%s = outerGl0wFunc(%s, %s.xy, %s, %s, %s, vec4(%s, %s));
%s = %s%s.rgb;
%s = %s%s.a;""" % [
output_vars[0], output_vars[1], input_vars[0], input_vars[1], input_vars[2], input_vars[3], input_vars[4], input_vars[5], input_vars[6],
output_vars[0], output_vars[0], output_vars[1],
output_vars[1], output_vars[0], output_vars[1]]
