vec2 _vec2ComposeFunc(float _vec2_length, float _vec2_angle_radians){
	return vec2(cos(_vec2_angle_radians), sin(_vec2_angle_radians)) * _vec2_length;
}