#pragma header

vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv * openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;

uniform float iTime;
uniform float blend;

#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main

void mainImage(void)
{
    vec2 q = fragCoord.xy / iResolution.xy;
    vec2 uv = q;

    // Wavy distortion (affects base UV position)
    float wave = sin(0.3 * iTime + uv.y * 21.0) *
                 sin(0.7 * iTime + uv.y * 29.0) *
                 sin(0.3 + 0.33 * iTime + uv.y * 31.0) * 0.002; // slight increase

    // Animated chromatic aberration offsets
    float amount = 0.0012;
    float rOffset = sin(iTime * 2.0) * amount;
    float gOffset = sin(iTime * 2.0 + 2.0) * amount;
    float bOffset = sin(iTime * 2.0 + 4.0) * amount;

    // Apply wave + RGB offsets
    vec3 col;
    col.r = texture(iChannel0, vec2(uv.x + wave + rOffset, uv.y)).r;
    col.g = texture(iChannel0, vec2(uv.x + wave + gOffset, uv.y)).g;
    col.b = texture(iChannel0, vec2(uv.x + wave + bOffset, uv.y)).b;

    // Optional glow boost (small accent)
    col.r += 0.02 * texture(iChannel0, vec2(uv.x + wave + rOffset + 0.01, uv.y)).r;
    col.g += 0.02 * texture(iChannel0, vec2(uv.x + wave + gOffset - 0.01, uv.y)).g;
    col.b += 0.02 * texture(iChannel0, vec2(uv.x + wave + bOffset + 0.005, uv.y)).b;

    // Contrast boost
    col = clamp(col * 0.6 + 0.4 * col * col, 0.0, 1.0);

    // Vignette
    float vig = 16.0 * uv.x * uv.y * (1.0 - uv.x) * (1.0 - uv.y);
    col *= vec3(pow(vig, 0.3));

    // Mix with original color for smooth transitions
    vec3 oricol = texture(iChannel0, uv).rgb;
    col = mix(oricol, col, blend);

    fragColor = vec4(col, 1.0);
}
