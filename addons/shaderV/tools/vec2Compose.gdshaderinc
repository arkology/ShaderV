vec2 _vec2ComposeFunc(float _vec2_length, float _vec2_angl_rad){
	return vec2(cos(_vec2_angl_rad), sin(_vec2_angl_rad)) * _vec2_length;
}