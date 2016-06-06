// basic.vert

precision highp float;
attribute vec3 aVertexPosition;
attribute vec2 aTextureCoord;
attribute vec3 aNormal;

uniform mat4 uModelMatrix;
uniform mat4 uViewMatrix;
uniform mat4 uProjectionMatrix;
uniform vec3 uPosition;
uniform vec3 uScale;
uniform float uRotation;
uniform float uHeightOffset;

varying vec2 vTextureCoord;
varying vec3 vNormal;
varying vec3 vPosition;
varying vec3 vOrgPosition;

vec2 rotate(vec2 v, float a) {
	float s = sin(a);
	float c = cos(a);
	mat2 m = mat2(c, -s, s, c);
	return m * v;
}

void main(void) {
	vec3 pos      = aVertexPosition * uScale;
	pos.xz 		  = rotate(pos.xz, uRotation);

	pos 		  += uPosition;
	pos.y 		  *= uHeightOffset;
	gl_Position   = uProjectionMatrix * uViewMatrix * uModelMatrix * vec4(pos, 1.0);
	vTextureCoord = aTextureCoord;
	vNormal       = aNormal;
	vNormal.xz 	  = rotate(vNormal.xz, uRotation);
	vPosition     = pos;

	vOrgPosition  = aVertexPosition;
}