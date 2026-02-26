#pragma header

void main() {
    vec4 color = flixel_texture2D(bitmap, openfl_TextureCoordv);
    float gray = (color.r + color.g + color.b) / 3.0;
    gl_FragColor = vec4(vec3(gray), color.a);
}
