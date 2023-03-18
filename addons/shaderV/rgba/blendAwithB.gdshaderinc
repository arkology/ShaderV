vec4 _blendAwithBFunc(vec4 _color_blendA_rgba, vec4 _color_blendB_rgba, float _fade_blend_color){
	return mix(_color_blendA_rgba, _color_blendB_rgba, _color_blendB_rgba.a * _fade_blend_color);
}