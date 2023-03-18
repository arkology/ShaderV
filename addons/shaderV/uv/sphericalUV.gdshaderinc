vec2 _sphericalUV(vec2 _spherical_uv, vec2 _spherical_position_vect, vec2 _spherical_radius_vect, vec2 _spherical_spin_vect, vec2 _spherical_local_position_vect){
	vec2 _temp_p = (_spherical_uv - _spherical_position_vect) * 2.0;
	float _temp_rad = length((_temp_p - _spherical_local_position_vect) * _spherical_radius_vect) + 0.0001;
	float _temp_f = (1.0 - sqrt(1.0 - _temp_rad)) / _temp_rad;
	return mod(vec2((_temp_p.x * 0.5 * _temp_f + _spherical_spin_vect.x) + 0.5,
					(_temp_p.y * 0.5 * _temp_f + _spherical_spin_vect.y) + 0.5), vec2(1.0));
}