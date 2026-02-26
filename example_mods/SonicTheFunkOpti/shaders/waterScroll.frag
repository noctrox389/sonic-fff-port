#pragma header

uniform float iTime;
uniform float intensity;

void main() {
    vec2 uv = openfl_TextureCoordv;

    // ===== Gentle horizontal waving =====
    // Very close waves and faster movement
    float wave = sin((uv.y * 180.0) + iTime * 6.0) * 0.0015 * intensity;

    // Apply horizontal offset
    uv.x = openfl_TextureCoordv.x + wave;

    // Clamp to avoid edge sampling artifacts
    uv.x = clamp(uv.x, 0.0001, 0.9999);

    vec4 color = flixel_texture2D(bitmap, uv);
    gl_FragColor = color;
}
