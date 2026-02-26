#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv * openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main

vec2 curve(vec2 uv)
{
	uv = (uv - 0.5) * 2.0;
	uv *= 1.1;
	uv.x *= 1.0 + pow((abs(uv.y) / 5.0), 2.0);
	uv.y *= 1.0 + pow((abs(uv.x) / 4.0), 2.0);
	uv = (uv / 2.0) + 0.5;
	uv = uv * 0.92 + 0.04;
	return uv;
}

void mainImage(void)
{
	vec2 q = fragCoord.xy / iResolution.xy;
	vec2 uv = curve(q);
	vec3 oricol = texture(iChannel0, q).xyz;
	vec3 col;

	float x = sin(0.3*iTime + uv.y*21.0) * sin(0.7*iTime + uv.y*29.0) * sin(0.3 + 0.33*iTime + uv.y*31.0) * 0.0017;

	col.r = texture(iChannel0, vec2(x + uv.x + 0.0006, uv.y + 0.0006)).x + 0.05;
	col.g = texture(iChannel0, vec2(x + uv.x + 0.0000, uv.y - 0.0012)).y + 0.05;
	col.b = texture(iChannel0, vec2(x + uv.x - 0.0012, uv.y + 0.0000)).z + 0.05;

	col.r += 0.08 * texture(iChannel0, 0.75 * vec2(x + 0.020, -0.020) + vec2(uv.x + 0.0006, uv.y + 0.0006)).x;
	col.g += 0.05 * texture(iChannel0, 0.75 * vec2(x - 0.018, -0.015) + vec2(uv.x + 0.0000, uv.y - 0.0012)).y;
	col.b += 0.08 * texture(iChannel0, 0.75 * vec2(x - 0.016, -0.014) + vec2(uv.x - 0.0012, uv.y + 0.0000)).z;

	vec3 glow = col * col;
	col = mix(col, glow, 0.5);

	col *= vec3(0.95, 1.05, 0.95);

	col *= 1.0 + 0.01 * sin(110.0 * iTime);

	if (uv.x < 0.0 || uv.x > 1.0) col *= 0.0;
	if (uv.y < 0.0 || uv.y > 1.0) col *= 0.0;

	col *= 1.0 - 0.65 * vec3(clamp((mod(fragCoord.x, 2.0) - 1.0) * 2.0, 0.0, 1.0));

	col *= 1.2;

	col = clamp(col, 0.0, 1.0);

	fragColor = vec4(col, 1.0);
}
