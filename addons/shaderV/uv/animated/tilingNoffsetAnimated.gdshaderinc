vec2 _tilingNoffsetAnimatedFunc(vec2 _tilingNoffset_uv, float _tilingNoffset_time, vec2 _tilingNoffset_offset_vect){
	return vec2(mod((_tilingNoffset_uv.x + _tilingNoffset_offset_vect.x * _tilingNoffset_time), 1.0),
				mod((_tilingNoffset_uv.y + _tilingNoffset_offset_vect.y * _tilingNoffset_time), 1.0));
}