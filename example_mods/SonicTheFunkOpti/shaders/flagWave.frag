#pragma header

uniform float iTime;     // time for waving
uniform float intensity; // vertical wave strength

void main() {
    vec2 uv = openfl_TextureCoordv;

    // ===== Big, vertical waving (slightly toned down) =====
    float wave = sin(uv.x * 10.0 + iTime * 10.0) * 0.07 * intensity; // reduced from 0.12 to 0.07
    uv.y += wave;

    // Sample the texture
    vec4 color = flixel_texture2D(bitmap, uv);
    gl_FragColor = color;
}
