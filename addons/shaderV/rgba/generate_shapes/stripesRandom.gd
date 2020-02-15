tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAcreateStripesRandom

func _init() -> void:
	set_input_port_default_value(1, 0.5)
	set_input_port_default_value(2, 20.0)
	set_input_port_default_value(3, Vector3(1.0, 1.0, 1.0))
	set_input_port_default_value(4, 1)

func _get_name() -> String:
	return "RandomStripesShape"

func _get_category() -> String:
	return "RGBA"

func _get_subcategory():
	return "Shapes"

func _get_description() -> String:
	return "Random horizontal lines creation"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 5

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "fill"
		2:
			return "amount"
		3:
			return "color"
		4:
			return "alpha"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR
		3:
			return VisualShaderNode.PORT_TYPE_VECTOR
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
float generateRand0mStripesFunc(vec2 _uv_stripes, float _fill_stripes, float _amount_stripes){
	_fill_stripes = min(max(_fill_stripes, 0.0), 1.0);
	return 1.0 - step(_fill_stripes, fract(sin(dot(floor(vec2(_uv_stripes.y) * _amount_stripes), vec2(12.9898, 78.233))) * 43758.5453123));
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return """%s = %s;
%s = generateRand0mStripesFunc(%s.xy, %s, %s) * %s;""" % [output_vars[0], input_vars[3],
output_vars[1], input_vars[0], input_vars[1], input_vars[2], input_vars[4]]
