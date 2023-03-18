vec2 _tiling_and_offset(vec2 _tiling_and_offset_uv, vec2 _tiling_and_offset_offset_vect){
	return vec2(mod(_tiling_and_offset_uv.x + _tiling_and_offset_offset_vect.x, 1.0),
				mod(_tiling_and_offset_uv.y + _tiling_and_offset_offset_vect.y, 1.0));
}