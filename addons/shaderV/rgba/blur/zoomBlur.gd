tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAzoomBlur

func _init() -> void:
	set_input_port_default_value(2, -1.0)
	set_input_port_default_value(3, Vector3(0.5, 0.5, 0.0))
	set_input_port_default_value(4, 20.0)
	set_input_port_default_value(5, 0.005)

func _get_name() -> String:
	return "ZoomBlur"

func _get_category() -> String:
	return "RGBA"

func _get_subcategory():
	return "Blur"

func _get_description() -> String:
	return """Zoom blur using [amount] samples
Note: negative lod => detect lod automatically"""

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 6

func _get_input_port_name(port: int):
	match port:
		0:
			return "sampler2D"
		1:
			return "uv"
		2:
			return "lod"
		3:
			return "pivot"
		4:
			return "amount"
		5:
			return "length"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_SAMPLER
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR
		3:
			return VisualShaderNode.PORT_TYPE_VECTOR
		4:
			return VisualShaderNode.PORT_TYPE_SCALAR
		5:
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
vec4 zoomBlurFunc(sampler2D _tex_z00m_blur, vec2 _uv_z00m_blur, int _amount_z00m_blur, vec2 _center_zoom, float _lgt_z00m_blur, float _lod_z00m_blur){
	vec4 _col_z00m_blur;
	if (_lod_z00m_blur < 0.0){
		_col_z00m_blur = texture(_tex_z00m_blur, _uv_z00m_blur);
		for (int i = 1; i <= _amount_z00m_blur; i++){
			float _temp_d_z00m_blur = _lgt_z00m_blur * float(i);
			vec2 px = _uv_z00m_blur * (1.0 - _temp_d_z00m_blur) + _center_zoom * _temp_d_z00m_blur;
			_col_z00m_blur += texture(_tex_z00m_blur, px);
		}
	}else{
		_col_z00m_blur = textureLod(_tex_z00m_blur, _uv_z00m_blur, _lod_z00m_blur);
		for (int i = 1; i <= _amount_z00m_blur; i++){
			float _temp_d_z00m_blur = _lgt_z00m_blur * float(i);
			vec2 px = _uv_z00m_blur * (1.0 - _temp_d_z00m_blur) + _center_zoom * _temp_d_z00m_blur;
			_col_z00m_blur += textureLod(_tex_z00m_blur, px, _lod_z00m_blur);
		}
	}
	_col_z00m_blur = _col_z00m_blur / float(_amount_z00m_blur + 1);
	return _col_z00m_blur;
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return """vec4 %s%s = zoomBlurFunc(%s, %s.xy, int(%s), %s.xy, %s, %s);
%s = %s%s.rgb;
%s = %s%s.a;""" % [
output_vars[0], output_vars[1], input_vars[0], input_vars[1], input_vars[4], input_vars[3], input_vars[5], input_vars[2],
output_vars[0], output_vars[0], output_vars[1],
output_vars[1], output_vars[0], output_vars[1]]
