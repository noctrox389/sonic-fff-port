#pragma header

uniform float levels; // number of color levels per channel

void main() {
    vec4 color = flixel_texture2D(bitmap, openfl_TextureCoordv);
    color.rgb = floor(color.rgb * levels) / levels;
    gl_FragColor = color;
}
