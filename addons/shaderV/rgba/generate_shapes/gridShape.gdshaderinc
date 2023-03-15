vec4 _gridFunc(vec2 _grid_uv, vec2 _gridline_thickness, vec2 _gridline_smooth, vec2 _gridcell_count, vec4 _grid_col, vec4 _grid_bg_col){
	vec2 _grid_vec = fract(_grid_uv * _gridcell_count);
	_grid_vec = min(_grid_vec, vec2(1.0) - _grid_vec);
	_grid_vec = smoothstep(_grid_vec - _gridline_smooth, _grid_vec + _gridline_smooth, _gridline_thickness / vec2(2.0));
//	return mix(_grid_bg_col, _grid_col, clamp(_grid_vec.x + _grid_vec.y, 0.0, 1.0));
	return mix(_grid_bg_col, _grid_col, (_grid_vec.x + _grid_vec.y));
}