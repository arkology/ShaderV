@tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRGBAfireFX

func _init():
	set_input_port_default_value(1, Vector3(0, 1, 0))
	set_input_port_default_value(2, 0.3)
	set_input_port_default_value(3, Vector3(1, 1, 0))
	set_input_port_default_value(4, 1.0)
	set_input_port_default_value(5, Vector3(1, 0.5, 0))
	set_input_port_default_value(6, 1.0)
	set_input_port_default_value(7, Vector3(1, 0, 0))
	set_input_port_default_value(8, 1.0)
	set_input_port_default_value(9, 0.0)
	set_input_port_default_value(10, 0.4)
	set_input_port_default_value(11, 0.2)
	set_input_port_default_value(12, 0.0)

func _get_name() -> String:
	return "FireFX"

func _get_category() -> String:
	return "RGBA"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return """3-step fire based on perling noise"""

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_input_port_count() -> int:
	return 13

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "direction"
		2:
			return "speed"
		3:
			return "color1"
		4:
			return "alpha1"
		5:
			return "color2"
		6:
			return "alpha2"
		7:
			return "color3"
		8:
			return "alpha3"
		9:
			return "col1pos"
		10:
			return "col2pos"
		11:
			return "col3pos"
		12:
			return "time"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR
		3:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		4:
			return VisualShaderNode.PORT_TYPE_SCALAR
		5:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		6:
			return VisualShaderNode.PORT_TYPE_SCALAR
		7:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		8:
			return VisualShaderNode.PORT_TYPE_SCALAR
		9:
			return VisualShaderNode.PORT_TYPE_SCALAR
		10:
			return VisualShaderNode.PORT_TYPE_SCALAR
		11:
			return VisualShaderNode.PORT_TYPE_SCALAR
		12:
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
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_global_code(mode):
	var path = self.get_script().get_path().get_base_dir()
	return '#include "' + path + '/fireFX.gdshaderinc"'

func _get_code(input_vars, output_vars, mode, type):
	var uv = "UV"
	
	if input_vars[0]:
		uv = input_vars[0]
	
	return """vec4 %s%s = _fireFXFunc(%s.xy, %s.xy, %s, %s, vec4(%s, %s), vec4(%s, %s), vec4(%s, %s), %s, %s, %s);
%s = %s%s.rgb;
%s = %s%s.a;""" % [
output_vars[0], output_vars[1], uv, input_vars[1], input_vars[2], input_vars[12], input_vars[3], input_vars[4],
				input_vars[5], input_vars[6], input_vars[7], input_vars[8], input_vars[9], input_vars[10], input_vars[11], 
output_vars[0], output_vars[0], output_vars[1],
output_vars[1], output_vars[0], output_vars[1]]
