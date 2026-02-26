#pragma header

uniform float iTime;
uniform float intensity;

void main() {
    vec2 uv = openfl_TextureCoordv;

    // Wavy distortion
    uv.y += sin(uv.x * 10.0 + iTime * 2.0) * 0.01 * intensity;
    uv.x += cos(uv.y * 10.0 + iTime * 2.0) * 0.01 * intensity;

    vec4 color = flixel_texture2D(bitmap, uv);

    // Grayscale effect
    float gray = (color.r + color.g + color.b) / 3.0;
    vec3 finalColor = mix(color.rgb, vec3(gray), intensity);

    gl_FragColor = vec4(finalColor, color.a);
}
