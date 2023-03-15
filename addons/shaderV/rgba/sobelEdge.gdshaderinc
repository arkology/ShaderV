float _sobelEdgeFunc(sampler2D _tex_sobel, vec2 _uv_sobel, float _lod_sobel, float _ofst_sobel, bool _preconv_grayscale_sobel, bool _use_scharr){
	vec3 s00 = vec3(0.0);
	vec3 s01 = vec3(0.0);
	vec3 s02 = vec3(0.0);
	vec3 s10 = vec3(0.0);
	vec3 s12 = vec3(0.0);
	vec3 s20 = vec3(0.0);
	vec3 s21 = vec3(0.0);
	vec3 s22 = vec3(0.0);
	if (_lod_sobel < 0.0){
		s00 = texture(_tex_sobel, _uv_sobel + _ofst_sobel * vec2(-1.0, -1.0)).rgb;
		s01 = texture(_tex_sobel, _uv_sobel + _ofst_sobel * vec2( 0.0, -1.0)).rgb;
		s02 = texture(_tex_sobel, _uv_sobel + _ofst_sobel * vec2( 1.0, -1.0)).rgb;
		s10 = texture(_tex_sobel, _uv_sobel + _ofst_sobel * vec2(-1.0,  0.0)).rgb;
		s12 = texture(_tex_sobel, _uv_sobel + _ofst_sobel * vec2( 1.0,  0.0)).rgb;
		s20 = texture(_tex_sobel, _uv_sobel + _ofst_sobel * vec2(-1.0,  1.0)).rgb;
		s21 = texture(_tex_sobel, _uv_sobel + _ofst_sobel * vec2( 0.0,  1.0)).rgb;
		s22 = texture(_tex_sobel, _uv_sobel + _ofst_sobel * vec2( 1.0,  1.0)).rgb;
	}else{
		s00 = textureLod(_tex_sobel, _uv_sobel + _ofst_sobel * vec2(-1.0, -1.0), _lod_sobel).rgb;
		s01 = textureLod(_tex_sobel, _uv_sobel + _ofst_sobel * vec2( 0.0, -1.0), _lod_sobel).rgb;
		s02 = textureLod(_tex_sobel, _uv_sobel + _ofst_sobel * vec2( 1.0, -1.0), _lod_sobel).rgb;
		s10 = textureLod(_tex_sobel, _uv_sobel + _ofst_sobel * vec2(-1.0,  0.0), _lod_sobel).rgb;
		s12 = textureLod(_tex_sobel, _uv_sobel + _ofst_sobel * vec2( 1.0,  0.0), _lod_sobel).rgb;
		s20 = textureLod(_tex_sobel, _uv_sobel + _ofst_sobel * vec2(-1.0,  1.0), _lod_sobel).rgb;
		s21 = textureLod(_tex_sobel, _uv_sobel + _ofst_sobel * vec2( 0.0,  1.0), _lod_sobel).rgb;
		s22 = textureLod(_tex_sobel, _uv_sobel + _ofst_sobel * vec2( 1.0,  1.0), _lod_sobel).rgb;
	}
	if (_preconv_grayscale_sobel){
		s00.x = 0.2126 * s00.r + 0.7152 * s00.g + 0.0722 * s00.b;
		s01.x = 0.2126 * s01.r + 0.7152 * s01.g + 0.0722 * s01.b;
		s02.x = 0.2126 * s02.r + 0.7152 * s02.g + 0.0722 * s02.b;
		s10.x = 0.2126 * s10.r + 0.7152 * s10.g + 0.0722 * s10.b;
		s12.x = 0.2126 * s12.r + 0.7152 * s12.g + 0.0722 * s12.b;
		s20.x = 0.2126 * s20.r + 0.7152 * s20.g + 0.0722 * s20.b;
		s21.x = 0.2126 * s21.r + 0.7152 * s21.g + 0.0722 * s21.b;
		s22.x = 0.2126 * s22.r + 0.7152 * s22.g + 0.0722 * s22.b;
	}
	float edgeSqr = 0.0;
	if (!_use_scharr) {
		float sobelX = s00.x + 2.0 * s10.x + s20.x - s02.x - 2.0 * s12.x - s22.x;
		float sobelY = s00.x + 2.0 * s01.x + s02.x - s20.x - 2.0 * s21.x - s22.x;
		edgeSqr = (sobelX * sobelX + sobelY * sobelY);
	}else{
		float scharrX = 3.0 * s00.x + 10.0 * s10.x + 3.0 * s20.x - 3.0 * s02.x - 10.0 * s12.x - 3.0 * s22.x;
		float scharrY = 3.0 * s00.x + 10.0 * s01.x + 3.0 * s02.x - 3.0 * s20.x - 10.0 * s21.x - 3.0 * s22.x;
		edgeSqr = (scharrX * scharrX + scharrY * scharrY);
	}
	return edgeSqr;
}