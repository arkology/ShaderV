tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAnormalFromHeightmap

func _init() -> void:
	set_input_port_default_value(2, Vector3(64, 64, 0))
	set_input_port_default_value(3, 10)
	set_input_port_default_value(4, false)
	set_input_port_default_value(5, false)
	set_input_port_default_value(6, false)

func _get_name() -> String:
	return "NormalFromHeightmap"

func _get_category() -> String:
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return """Create normal map from heightmap texture. You should provide actual size of heightmap (in pixels).
It always uses 0 lod of heightmap texture to create normalmap.
It's possible to invert X and Y of normalmap if needed.
If you provide texture with different colors (not actual heightmap) to 'heightmapSampler', you can set 'preconvertToGray' to 'true'."""

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 7

func _get_input_port_name(port: int):
	match port:
		0:
			return "heightmapSampler"
		1:
			return "uv"
		2:
			return "heightmapSize"
		3:
			return "strength"
		4:
			return "preconvertToGray"
		5:
			return "invertX"
		6:
			return "invertY"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_SAMPLER
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR
		2:
			return VisualShaderNode.PORT_TYPE_VECTOR
		3:
			return VisualShaderNode.PORT_TYPE_SCALAR
		4:
			return VisualShaderNode.PORT_TYPE_BOOLEAN
		5:
			return VisualShaderNode.PORT_TYPE_BOOLEAN
		6:
			return VisualShaderNode.PORT_TYPE_BOOLEAN

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "normal"

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_global_code(mode: int) -> String:
	return """
vec3 normalFromHeightmapFunc(vec2 _hm_uv, sampler2D _hm_tex, vec2 _hm_size, float _norm_hm_strgth, bool _conv_hm_gray, bool _inv_x_norm, bool _inv_y_norm){
	vec3 _hm_down = textureLod(_hm_tex, _hm_uv + vec2(0.0, 1.0 / _hm_size.y), 0.0).rgb;
	vec3 _hm_up = textureLod(_hm_tex, _hm_uv - vec2(0.0, 1.0 / _hm_size.y), 0.0).rgb;
	vec3 _hm_right = textureLod(_hm_tex, _hm_uv + vec2(1.0 / _hm_size.x, 0.0), 0.0).rgb;
	vec3 _hm_left = textureLod(_hm_tex, _hm_uv - vec2(1.0 / _hm_size.x, 0.0), 0.0).rgb;
	
	if (_conv_hm_gray) {
		_hm_down.r = 0.2126 * _hm_down.r + 0.7152 * _hm_down.g + 0.0722 * _hm_down.b;
		_hm_up.r = 0.2126 * _hm_up.r + 0.7152 * _hm_up.g + 0.0722 * _hm_up.b;
		_hm_right.r = 0.2126 * _hm_right.r + 0.7152 * _hm_right.g + 0.0722 * _hm_right.b;
		_hm_left.r = 0.2126 * _hm_left.r + 0.7152 * _hm_left.g + 0.0722 * _hm_left.b;
	}
	
	float dx = (1.0 - float(_inv_x_norm)) * (_hm_left.r - _hm_right.r) + 
				(float(_inv_x_norm)) * (-_hm_left.r + _hm_right.r);
	float dy = (1.0 - float(_inv_y_norm)) * (_hm_up.r - _hm_down.r) + 
				(float(_inv_y_norm)) * (-_hm_up.r + _hm_down.r);
	
	return normalize(vec3(dx, dy, 1.0 / _norm_hm_strgth));
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s = normalFromHeightmapFunc(%s.xy, %s, %s.xy, %s, %s, %s, %s);" % [
output_vars[0], input_vars[1], input_vars[0], input_vars[2], input_vars[3], input_vars[4], input_vars[5], input_vars[6]]
