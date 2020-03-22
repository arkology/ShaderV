tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeNoiseWorley3dFractal

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
	set_input_port_default_value(10, 0)

func _get_name() -> String:
	return "FractalWorleyNoise3D"

func _get_category() -> String:
	return "RGBA"

func _get_subcategory() -> String:
	return "NoiseFractal"

func _get_description() -> String:
	return "Fractal WorleyNoise3D"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_input_port_count() -> int:
	return 11

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
		10:
			return "time"

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
		10:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "result"

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_global_code(mode: int) -> String:
	return """
vec2 cellular3dNoiseFractalFunc(vec3 P, float _jitter_w3d) {
	float K = 0.142857142857;
	float Ko = 0.428571428571;
	float K2 = 0.020408163265306;
	float Kz = 0.166666666667;
	float Kzo = 0.416666666667;
	
	vec3 Pi = floor(P) - floor(floor(P) * (1.0 / 289.0)) * 289.0;
	vec3 Pf = fract(P) - 0.5;
	
	vec3 Pfx = Pf.x + vec3(1.0, 0.0, -1.0);
	vec3 Pfy = Pf.y + vec3(1.0, 0.0, -1.0);
	vec3 Pfz = Pf.z + vec3(1.0, 0.0, -1.0);
	
	vec3 p = ((34.0*(Pi.x+vec3(-1.0,0.0,1.0))+1.0)*(Pi.x+vec3(-1.0,0.0,1.0)))-floor(((34.0*(Pi.x+vec3(-1.0,0.0,1.0))+1.0)
				*(Pi.x+vec3(-1.0,0.0,1.0)))*(1.0/289.0))*289.0;
	vec3 p1 = ((34.0*(p+Pi.y-1.0)+1.0)*(p+Pi.y-1.0))-floor(((34.0*(p+Pi.y-1.0)+1.0)*(p+Pi.y-1.0))*(1.0/289.0))*289.0;
	vec3 p2 = ((34.0*(p+Pi.y)+1.0)*(p+Pi.y))-floor(((34.0*(p+Pi.y)+1.0)*(p+Pi.y))*(1.0/289.0))*289.0;
	vec3 p3 = ((34.0*(p+Pi.y+1.0)+1.0)*(p+Pi.y+1.0))-floor(((34.0*(p+Pi.y+1.0)+1.0)*(p+Pi.y+1.0))*(1.0/289.0))*289.0;
	
	vec3 p11 = ((34.0*(p1+Pi.z-1.0)+1.0)*(p1+Pi.z-1.0))-floor(((34.0*(p1+Pi.z-1.0)+1.0)*(p1+Pi.z-1.0))*(1.0/289.0))*289.0;
	vec3 p12 = ((34.0*(p1+Pi.z)+1.0)*(p1+Pi.z))-floor(((34.0*(p1+Pi.z)+1.0)*(p1+Pi.z))*(1.0/289.0))*289.0;
	vec3 p13 = ((34.0*(p1+Pi.z+1.0)+1.0)*(p1+Pi.z+1.0))-floor(((34.0*(p1+Pi.z+1.0)+1.0)*(p1+Pi.z+1.0))*(1.0/289.0))*289.0;
	
	vec3 p21 = ((34.0*(p2+Pi.z-1.0)+1.0)*(p2+Pi.z-1.0))-floor(((34.0*(p2+Pi.z-1.0)+1.0)*(p2+Pi.z-1.0))*(1.0/289.0))*289.0;
	vec3 p22 = ((34.0*(p2+Pi.z)+1.0)*(p2+Pi.z))-floor(((34.0*(p2+Pi.z)+1.0)*(p2+Pi.z))*(1.0/289.0))*289.0;
	vec3 p23 = ((34.0*(p2+Pi.z+1.0)+1.0)*(p2+Pi.z+1.0))-floor(((34.0*(p2+Pi.z+1.0)+1.0)*(p2+Pi.z+1.0))*(1.0/289.0))*289.0;
	
	vec3 p31 = ((34.0*(p3+Pi.z-1.0)+1.0)*(p3+Pi.z-1.0))-floor(((34.0*(p3+Pi.z-1.0)+1.0)*(p3+Pi.z-1.0))*(1.0/289.0))*289.0;
	vec3 p32 = ((34.0*(p3+Pi.z)+1.0)*(p3+Pi.z))-floor(((34.0*(p3+Pi.z)+1.0)*(p3+Pi.z))*(1.0/289.0))*289.0;
	vec3 p33 = ((34.0*(p3+Pi.z+1.0)+1.0)*(p3+Pi.z+1.0))-floor(((34.0*(p3+Pi.z+1.0)+1.0)*(p3+Pi.z+1.0))*(1.0/289.0))*289.0;
	
	vec3 ox11 = fract(p11*K) - Ko;
	vec3 oy11 = ((floor(p11*K))-floor((floor(p11*K))*(1.0/7.0))*7.0)*K - Ko;
	vec3 oz11 = floor(p11*K2)*Kz - Kzo;
	
	vec3 ox12 = fract(p12*K) - Ko;
	vec3 oy12 = ((floor(p12*K))-floor((floor(p12*K))*(1.0/7.0))*7.0)*K - Ko;
	vec3 oz12 = floor(p12*K2)*Kz - Kzo;
	
	vec3 ox13 = fract(p13*K) - Ko;
	vec3 oy13 = ((floor(p13*K))-floor((floor(p13*K))*(1.0/7.0))*7.0)*K - Ko;
	vec3 oz13 = floor(p13*K2)*Kz - Kzo;
	
	vec3 ox21 = fract(p21*K) - Ko;
	vec3 oy21 = ((floor(p21*K))-floor((floor(p21*K))*(1.0/7.0))*7.0)*K - Ko;
	vec3 oz21 = floor(p21*K2)*Kz - Kzo;
	
	vec3 ox22 = fract(p22*K) - Ko;
	vec3 oy22 = ((floor(p22*K))-floor((floor(p22*K))*(1.0/7.0))*7.0)*K - Ko;
	vec3 oz22 = floor(p22*K2)*Kz - Kzo;
	
	vec3 ox23 = fract(p23*K) - Ko;
	vec3 oy23 = ((floor(p23*K))-floor((floor(p23*K))*(1.0/7.0))*7.0)*K - Ko;
	vec3 oz23 = floor(p23*K2)*Kz - Kzo;
	
	vec3 ox31 = fract(p31*K) - Ko;
	vec3 oy31 = ((floor(p31*K))-floor((floor(p31*K))*(1.0/7.0))*7.0)*K - Ko;
	vec3 oz31 = floor(p31*K2)*Kz - Kzo;
	
	vec3 ox32 = fract(p32*K) - Ko;
	vec3 oy32 = ((floor(p32*K))-floor((floor(p32*K))*(1.0/7.0))*7.0)*K - Ko;
	vec3 oz32 = floor(p32*K2)*Kz - Kzo;
	
	vec3 ox33 = fract(p33*K) - Ko;
	vec3 oy33 = ((floor(p33*K))-floor((floor(p33*K))*(1.0/7.0))*7.0)*K - Ko;
	vec3 oz33 = floor(p33*K2)*Kz - Kzo;
	
	vec3 dx11 = Pfx + _jitter_w3d*ox11;
	vec3 dy11 = Pfy.x + _jitter_w3d*oy11;
	vec3 dz11 = Pfz.x + _jitter_w3d*oz11;
	
	vec3 dx12 = Pfx + _jitter_w3d*ox12;
	vec3 dy12 = Pfy.x + _jitter_w3d*oy12;
	vec3 dz12 = Pfz.y + _jitter_w3d*oz12;
	
	vec3 dx13 = Pfx + _jitter_w3d*ox13;
	vec3 dy13 = Pfy.x + _jitter_w3d*oy13;
	vec3 dz13 = Pfz.z + _jitter_w3d*oz13;
	
	vec3 dx21 = Pfx + _jitter_w3d*ox21;
	vec3 dy21 = Pfy.y + _jitter_w3d*oy21;
	vec3 dz21 = Pfz.x + _jitter_w3d*oz21;
	
	vec3 dx22 = Pfx + _jitter_w3d*ox22;
	vec3 dy22 = Pfy.y + _jitter_w3d*oy22;
	vec3 dz22 = Pfz.y + _jitter_w3d*oz22;
	
	vec3 dx23 = Pfx + _jitter_w3d*ox23;
	vec3 dy23 = Pfy.y + _jitter_w3d*oy23;
	vec3 dz23 = Pfz.z + _jitter_w3d*oz23;
	
	vec3 dx31 = Pfx + _jitter_w3d*ox31;
	vec3 dy31 = Pfy.z + _jitter_w3d*oy31;
	vec3 dz31 = Pfz.x + _jitter_w3d*oz31;
	
	vec3 dx32 = Pfx + _jitter_w3d*ox32;
	vec3 dy32 = Pfy.z + _jitter_w3d*oy32;
	vec3 dz32 = Pfz.y + _jitter_w3d*oz32;
	
	vec3 dx33 = Pfx + _jitter_w3d*ox33;
	vec3 dy33 = Pfy.z + _jitter_w3d*oy33;
	vec3 dz33 = Pfz.z + _jitter_w3d*oz33;
	
	vec3 d11 = dx11 * dx11 + dy11 * dy11 + dz11 * dz11;
	vec3 d12 = dx12 * dx12 + dy12 * dy12 + dz12 * dz12;
	vec3 d13 = dx13 * dx13 + dy13 * dy13 + dz13 * dz13;
	vec3 d21 = dx21 * dx21 + dy21 * dy21 + dz21 * dz21;
	vec3 d22 = dx22 * dx22 + dy22 * dy22 + dz22 * dz22;
	vec3 d23 = dx23 * dx23 + dy23 * dy23 + dz23 * dz23;
	vec3 d31 = dx31 * dx31 + dy31 * dy31 + dz31 * dz31;
	vec3 d32 = dx32 * dx32 + dy32 * dy32 + dz32 * dz32;
	vec3 d33 = dx33 * dx33 + dy33 * dy33 + dz33 * dz33;

	vec3 d1a = min(d11, d12);
	d12 = max(d11, d12);
	d11 = min(d1a, d13);
	d13 = max(d1a, d13);
	d12 = min(d12, d13);
	vec3 d2a = min(d21, d22);
	d22 = max(d21, d22);
	d21 = min(d2a, d23);
	d23 = max(d2a, d23);
	d22 = min(d22, d23);
	vec3 d3a = min(d31, d32);
	d32 = max(d31, d32);
	d31 = min(d3a, d33);
	d33 = max(d3a, d33);
	d32 = min(d32, d33);
	vec3 da = min(d11, d21);
	d21 = max(d11, d21);
	d11 = min(da, d31);
	d31 = max(da, d31);
	d11.xy = (d11.x < d11.y) ? d11.xy : d11.yx;
	d11.xz = (d11.x < d11.z) ? d11.xz : d11.zx;
	d12 = min(d12, d21);
	d12 = min(d12, d22);
	d12 = min(d12, d31);
	d12 = min(d12, d32);
	d11.yz = min(d11.yz,d12.xy);
	d11.y = min(d11.y,d12.z);
	d11.y = min(d11.y,d11.z);
	return sqrt(d11.xy);
}
float cellularNoise3DFBM(vec2 _uv_cnfbm, int _oct_cnfbm, vec2 _per_cnfbm, float _lac_cnfbm, float _persist_cnfbm,
		float _rot_cnfbm, float _ampl_cnfbm, vec2 _shift_cnfbm, float _jitter_cnfbm, bool _use_F2_cnfbm, float _time_cnfbm) {
	float _v = 0.0;
	float _a = _ampl_cnfbm;
	mat2 _r0t = mat2(vec2(cos(_rot_cnfbm), sin(_rot_cnfbm)), vec2(-sin(_rot_cnfbm), cos(_rot_cnfbm)));
	for (int i = 0; i < _oct_cnfbm; ++i) {
		vec2 _cell_noiseF12 = cellular3dNoiseFractalFunc(vec3(_uv_cnfbm * _per_cnfbm, _time_cnfbm), _jitter_cnfbm);
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
	return "%s = cellularNoise3DFBM(%s.xy, int(%s), %s.xy, %s, %s, %s, %s, %s.xy, %s, %s, %s);" % [
	output_vars[0], input_vars[0], input_vars[1], input_vars[2], input_vars[3], input_vars[4],
	input_vars[5], input_vars[6], input_vars[7], input_vars[8], input_vars[9], input_vars[10]]
