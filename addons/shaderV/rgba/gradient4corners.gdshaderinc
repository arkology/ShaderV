vec4 _gradient4cornersFunc(vec2 _uv_corner, vec4 _top_left_corner, vec4 _top_right_corner, vec4 _bottom_left_corner, vec4 _bottom_right_corner){
	vec4 _color_top_corner = mix(_top_left_corner, _top_right_corner, _uv_corner.x);
	vec4 _color_bottom_corner = mix(_bottom_left_corner, _bottom_right_corner, _uv_corner.x);
	return mix(_color_top_corner, _color_bottom_corner, _uv_corner.y);
}