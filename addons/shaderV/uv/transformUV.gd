tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeUVtransform

func _init() -> void:
	set_input_port_default_value(1, Vector3(0, 0, 0))
	set_input_port_default_value(2, Vector3(1, 1, 0))
	set_input_port_default_value(3, Vector3(0.5, 0.5, 0))
	set_input_port_default_value(4, 0)
	set_input_port_default_value(5, Vector3(0.5, 0.5, 0))

func _get_name() -> String:
	return "TransformUV"

func _get_category() -> String:
	return "UV"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return "Performs offset, scale and rotation of UV with custom pivots. Rotation is set in radians."

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 6

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "offset"
		2:
			return "scale"
		3:
			return "scalePivot"
		4:
			return "rotation"
		5:
			return "rotationPivot"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR
		2:
			return VisualShaderNode.PORT_TYPE_VECTOR
		3:
			return VisualShaderNode.PORT_TYPE_VECTOR
		4:
			return VisualShaderNode.PORT_TYPE_SCALAR
		5:
			return VisualShaderNode.PORT_TYPE_VECTOR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "uv"

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_global_code(mode: int) -> String:
	return """
vec2 transformUVFunc(vec2 _uv_transform, vec2 _scale_uv_, vec2 _pivot_scale_uv_, vec2 _offset_uv_, float _rotate_uv, vec2 _pivot_rotate_uv_){
	_uv_transform -= _offset_uv_; // offset
	_uv_transform = (_uv_transform - _pivot_scale_uv_) * _scale_uv_ + _pivot_scale_uv_; // zoom
	vec2 _rot_uv_angl = vec2(cos(_rotate_uv), sin(_rotate_uv));
	mat2 _rot_matrix = mat2(vec2(_rot_uv_angl.x, - _rot_uv_angl.y), vec2(_rot_uv_angl.y, _rot_uv_angl.x));
	_uv_transform = (_uv_transform - _pivot_rotate_uv_) * _rot_matrix + _pivot_rotate_uv_; // rotate
	return _uv_transform;
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s.xy = transformUVFunc(%s.xy, %s.xy, %s.xy, %s.xy, %s, %s.xy);" % [
output_vars[0], input_vars[0], input_vars[2], input_vars[3], input_vars[1], input_vars[4], input_vars[5]]
