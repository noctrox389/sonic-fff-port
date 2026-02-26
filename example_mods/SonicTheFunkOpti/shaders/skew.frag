#pragma header

uniform float skewAmount;

void main() {
    vec2 uv = openfl_TextureCoordv;

    // Horizontal skew based on vertical position
    uv.x += (uv.y - 0.5) * skewAmount;

    vec4 col = flixel_texture2D(bitmap, uv);
    gl_FragColor = col;
}
