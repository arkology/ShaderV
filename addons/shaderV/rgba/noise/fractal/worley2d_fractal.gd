tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeNoiseWorley2dFractal

func _init() -> void:
	set_input_port_default_value(1, 6)
	set_input_port_default_value(2, Vector3(2, 2, 0))
	set_input_port_default_value(3, 2)
	set_input_port_default_value(4, 0.8)
	set_input_port_default_value(5, 0.5)
	set_input_port_default_value(6, 0.3)
	set_input_port_default_value(7, Vector3(0.5, 0.5, 0))
	set_input_port_default_value(8, 1)
	set_input_port_default_value(9, false)

func _get_name() -> String:
	return "FractalWorleyNoise2D"

func _get_category() -> String:
	return "RGBA"

func _get_subcategory() -> String:
	return "NoiseFractal"

func _get_description() -> String:
	return "Fractal WorleyNoise2D"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_input_port_count() -> int:
	return 10

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "octaves"
		2:
			return "period"
		3:
			return "lacunarity"
		4:
			return "persistence"
		5:
			return "angle"
		6:
			return "amplitude"
		7:
			return "shift"
		8:
			return "jitter"
		9:
			return "use_F2"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
		2:
			return VisualShaderNode.PORT_TYPE_VECTOR
		3:
			return VisualShaderNode.PORT_TYPE_SCALAR
		4:
			return VisualShaderNode.PORT_TYPE_SCALAR
		5:
			return VisualShaderNode.PORT_TYPE_SCALAR
		6:
			return VisualShaderNode.PORT_TYPE_SCALAR
		7:
			return VisualShaderNode.PORT_TYPE_VECTOR
		8:
			return VisualShaderNode.PORT_TYPE_SCALAR
		9:
			return VisualShaderNode.PORT_TYPE_BOOLEAN

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "result"

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_global_code(mode: int) -> String:
	return """
vec2 cellular2dNoiseFractalFunc(vec2 P, float _jitter_w2d) {
	float K = 0.142857142857; // 1/7
	float Ko = 0.428571428571; // 3/7
	
	vec2 Pi = floor(P) - floor(floor(P) * (1.0 / 289.0)) * 289.0;
	vec2 Pf = fract(P);
	vec3 oi = vec3(-1.0, 0.0, 1.0);
	vec3 of = vec3(-0.5, 0.5, 1.5);
	vec3 px = (34.0*(Pi.x+oi)+1.0)*(Pi.x+oi)-floor((34.0*(Pi.x+oi)+1.0)*(Pi.x+oi)*(1.0/289.0))* 289.0;
	vec3 p = (34.0*(px.x+Pi.y+ oi)+1.0)*(px.x+Pi.y+ oi)-floor((34.0*(px.x+Pi.y+oi)+1.0)*(px.x+Pi.y+ oi)*(1.0/289.0))*289.0;
	vec3 ox = fract(p*K) - Ko;
	vec3 oy = (floor(p*K) - floor(floor(p*K) * (1.0 / 7.0)) * 7.0) * K - Ko;
	vec3 dx = Pf.x + 0.5 + _jitter_w2d*ox;
	vec3 dy = Pf.y - of + _jitter_w2d*oy;
	vec3 d1 = dx * dx + dy * dy;
	p = (34.0*(px.y+Pi.y+oi)+1.0)*(px.y+Pi.y+oi)-floor((34.0*(px.y+Pi.y+oi)+1.0)*(px.y+Pi.y+oi)*(1.0/289.0))*289.0;
	ox = fract(p*K) - Ko;
	oy = (floor(p*K) - floor(floor(p*K) * (1.0 / 7.0)) * 7.0) * K - Ko;
	dx = Pf.x - 0.5 + _jitter_w2d*ox;
	dy = Pf.y - of + _jitter_w2d*oy;
	vec3 d2 = dx * dx + dy * dy;
	p = (34.0*(px.z+Pi.y+oi)+1.0)*(px.z+Pi.y+oi)-floor((34.0*(px.z+Pi.y+oi)+1.0)*(px.z+Pi.y+oi)*(1.0/289.0))*289.0;
	ox = fract(p*K) - Ko;
	oy = (floor(p*K) - floor(floor(p*K) * (1.0 / 7.0)) * 7.0) * K - Ko;
	dx = Pf.x - 1.5 + _jitter_w2d*ox;
	dy = Pf.y - of + _jitter_w2d*oy;
	vec3 d3 = dx * dx + dy * dy;
	vec3 d1a = min(d1, d2);
	d2 = max(d1, d2);
	d2 = min(d2, d3);
	d1 = min(d1a, d2);
	d2 = max(d1a, d2);
	d1.xy = (d1.x < d1.y) ? d1.xy : d1.yx;
	d1.xz = (d1.x < d1.z) ? d1.xz : d1.zx;
	d1.yz = min(d1.yz, d2.yz);
	d1.y = min(d1.y, d1.z);
	d1.y = min(d1.y, d2.x);
	return sqrt(d1.xy);
}
float cellularNoise2DFBM(vec2 _uv_cnfbm, int _oct_cnfbm, vec2 _per_cnfbm, float _lac_cnfbm, float _persist_cnfbm,
		float _rot_cnfbm, float _ampl_cnfbm, vec2 _shift_cnfbm, float _jitter_cnfbm, bool _use_F2_cnfbm) {
	float _v = 0.0;
	float _a = _ampl_cnfbm;
	mat2 _r0t = mat2(vec2(cos(_rot_cnfbm), sin(_rot_cnfbm)), vec2(-sin(_rot_cnfbm), cos(_rot_cnfbm)));
	for (int i = 0; i < _oct_cnfbm; ++i) {
		vec2 _cell_noiseF12 = cellular2dNoiseFractalFunc(_uv_cnfbm * _per_cnfbm, _jitter_cnfbm);
		if (_use_F2_cnfbm) {
			_v += _a * _cell_noiseF12.y;
		} else {
			_v += _a * _cell_noiseF12.x;
		}
		_uv_cnfbm = _r0t * _uv_cnfbm * _lac_cnfbm + _shift_cnfbm;
		_a *= _persist_cnfbm;
	}
	return _v;
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s = cellularNoise2DFBM(%s.xy, int(%s), %s.xy, %s, %s, %s, %s, %s.xy, %s, %s);" % [
	output_vars[0], input_vars[0], input_vars[1], input_vars[2], input_vars[3],
	input_vars[4], input_vars[5], input_vars[6], input_vars[7], input_vars[8], input_vars[9]]
