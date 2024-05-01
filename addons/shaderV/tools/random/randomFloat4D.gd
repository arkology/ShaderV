tool
extends VisualShaderNodeCustom
class_name VisualShaderToolsRandomFloat4D

enum Inputs {
	INPUT,
	W,
	SCALE,
	OFFSET,
	OFFSET_W,

	I_COUNT
}

const INPUT_NAMES = ["input", "w", "scale", "offset", "w_offset"];
const INPUT_TYPES = [
	VisualShaderNode.PORT_TYPE_VECTOR,
	VisualShaderNode.PORT_TYPE_SCALAR,
	VisualShaderNode.PORT_TYPE_SCALAR,
	VisualShaderNode.PORT_TYPE_VECTOR,
	VisualShaderNode.PORT_TYPE_SCALAR,
]

func _init():
	set_input_port_default_value(Inputs.INPUT, Vector3.ZERO)
	set_input_port_default_value(Inputs.W, 0.0)
	set_input_port_default_value(Inputs.SCALE, 1.0)
	set_input_port_default_value(Inputs.OFFSET, Vector3.ZERO)
	set_input_port_default_value(Inputs.OFFSET_W, 0.0)

func _get_name():
	return "RandomFloat4D"

func _get_category():
	return "Tools"

func _get_subcategory():
	return "Random"

func _get_description():
	return "Returns random float value based on 4D input vector"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_input_port_count():
	return Inputs.I_COUNT

func _get_input_port_name(port):
	return INPUT_NAMES[port]

func _get_input_port_type(port):
	return INPUT_TYPES[port]

func _get_output_port_count():
	return 1

func _get_output_port_name(port):
	return "result"

func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_global_code(mode):
	return """
	float gpu_random_float(vec4 co){
		float f = dot(fract(co) + fract(co * 2.32184321231),vec4(129.898,782.33,944.32214932,122.2834234542));
		return fract(sin(f) * 437588.5453);
	}
	"""

func _get_code(input_vars, output_vars, mode, type):
	return "%s = gpu_random_float(vec4(%s, %s) * %s + vec4(%s, %s));" % [
		output_vars[0],
		input_vars[Inputs.INPUT],
		input_vars[Inputs.W],
		input_vars[Inputs.SCALE],
		input_vars[Inputs.OFFSET],
		input_vars[Inputs.OFFSET_W]
	]
