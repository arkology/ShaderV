vec3 _sphericalToCartesianFunc(vec3 _spherical_vec3){
//	(r, theta, phi) -> (x, y, z)
	return vec3(_spherical_vec3.x * sin(_spherical_vec3.z) * cos(_spherical_vec3.y),
				_spherical_vec3.x * sin(_spherical_vec3.z) * sin(_spherical_vec3.y),
				_spherical_vec3.x * cos(_spherical_vec3.z));
}