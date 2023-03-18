vec3 _rotateUV(vec3 _rotate_uv, vec2 _rotate_pivot_vect, float _rotate_radians){
	//_r0tation_r0tate = radians(_r0tationDeg_r0tate);
	vec2 _rotation_angle = vec2(cos(_rotate_radians), sin(_rotate_radians));
	_rotate_uv.xy -= _rotate_pivot_vect;
	_rotate_uv.xy = vec2((_rotate_uv.x*_rotation_angle.x-_rotate_uv.y*_rotation_angle.y), 
						 (_rotate_uv.x*_rotation_angle.y+_rotate_uv.y*_rotation_angle.x));
	_rotate_uv.xy += _rotate_pivot_vect;
	return _rotate_uv;
}