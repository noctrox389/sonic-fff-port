#pragma header

uniform float iTime;       // time for waving
uniform float intensity;   // vertical wave strength
uniform float scrollSpeed; // horizontal scroll speed

void main() {
    vec2 uv = openfl_TextureCoordv;

    // ===== Faster horizontal scroll =====
    float offset = iTime * (scrollSpeed * 3.0); // <<< multiplied by 3 to go faster

    // wrap UVs without precision issues
    uv.x = mod(uv.x + offset, 1.0);

    // Slightly pull the UV inward to avoid sampling the extreme edge
    uv.x = clamp(uv.x, 0.0001, 0.9999);

    // ===== Vertical waving (unchanged) =====
    float wave = sin(uv.x * 10.0 + iTime * 5.0) * 0.02 * intensity;
    uv.y += wave;

    // Sample the texture
    vec4 color = flixel_texture2D(bitmap, uv);
    gl_FragColor = color;
}
