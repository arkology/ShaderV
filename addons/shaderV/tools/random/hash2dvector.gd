@tool
extends VisualShaderNodeCustom
class_name VisualShaderToolsHash2Dvec

func _get_name() -> String:
	return "HashRandom2dVec"

func _get_category() -> String:
	return "Tools"

func _get_subcategory() -> String:
	return "Random"

func _get_description() -> String:
	return "Hash func with vector input and vector output"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_input_port_count() -> int:
	return 1

func _get_input_port_name(port: int) -> String:
	return "in"

func _get_input_port_type(port):
	return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port ) -> String:
	return "vec"

func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_global_code(mode):
	var code : String = preload("hash2dvector.gdshaderinc").code
	return code

func _get_code(input_vars, output_vars, mode, type):
	return "%s.xy = _hash2v(%s.xy);" % [output_vars[0], input_vars[0]]
