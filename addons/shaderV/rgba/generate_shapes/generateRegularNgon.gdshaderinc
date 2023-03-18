float _polygonFunc(vec2 _uv_polygon, vec2 _pos_polygon, vec2 _size_polygon, float _sides_polygon, float _angle_polygon, float _smooth_polygon){
	_uv_polygon = (_uv_polygon - _pos_polygon) / (_size_polygon * 2.0);
	float a_polygon = atan(_uv_polygon.x, _uv_polygon.y) + _angle_polygon;
	float r_polygon = 6.28318530718 / float(int(max(_sides_polygon, 3.0)));
	float d_polygon = cos(floor(0.5 + a_polygon / r_polygon) * r_polygon - a_polygon) * length(_uv_polygon);
	return (max(sign(_smooth_polygon - 0.0), 0.0) * ( 1.0 - smoothstep(0.1 - 0.0001, 0.1 + _smooth_polygon, d_polygon) ) +
			(max(sign(-_smooth_polygon + 0.0), 0.0)) * ( 1.0 - smoothstep(0.1 + _smooth_polygon - 0.0001, 0.1, d_polygon) ) +
			(1.0 - abs(sign(_smooth_polygon - 0.0))) * ( 1.0 - step(0.1, d_polygon)) );
}