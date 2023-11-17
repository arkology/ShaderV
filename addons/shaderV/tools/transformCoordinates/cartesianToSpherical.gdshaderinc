vec3 _cartesianToSphericalFunc(vec3 _cartesian_vec3){
//	(x, y, z) -> (r, theta, phi)
	return vec3(length(_cartesian_vec3),
				atan(_cartesian_vec3.y, _cartesian_vec3.x),
				atan(length(_cartesian_vec3.xy), _cartesian_vec3.z));
}