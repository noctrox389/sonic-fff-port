#pragma header

uniform float iTime;
uniform float intensity;

void main() {
    vec2 uv = openfl_TextureCoordv;

    uv.x += intensity * (
        (sin((uv.y + (iTime * 0.07)) * 45.0) * 0.009) +
        (sin((uv.y + (iTime * 0.1)) * 35.0) * 0.005)
    );

    gl_FragColor = flixel_texture2D(bitmap, uv);
}
