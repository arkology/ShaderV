vec4 _shineFunc(vec4 _color_shine, vec2 _uv_shine, float _loc_shine, float _rot_shine, float _width_shine, float _soft_shine, float _bright_shine, float _gloss_shine, vec3 _shine_color_shine){
	vec2 _angle_shine = vec2(cos(_rot_shine), sin(_rot_shine));
	float _norm_pos_shine = dot(_uv_shine, _angle_shine);
	float _normal_shine = 1.0 - abs((_norm_pos_shine - _loc_shine) / _width_shine);
	float _shine_power_shine = smoothstep(0.0, _soft_shine * 2.0, _normal_shine);
	vec3 _reflect_color_shine = mix(vec3(1.0), _color_shine.rgb * 10.0, _gloss_shine);
	_color_shine.rgb += _color_shine.a * _shine_power_shine * _bright_shine * _reflect_color_shine * _shine_color_shine.rgb;
	return _color_shine;
}