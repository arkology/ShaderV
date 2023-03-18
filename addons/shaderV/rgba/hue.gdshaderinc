vec3 _hueFunc(float _inp_hue){
	return 3.0 * abs(1.0 - 2.0 * fract(_inp_hue + vec3(0.0, -1.0 / 3.0, 1.0 / 3.0))) - 1.0;
}