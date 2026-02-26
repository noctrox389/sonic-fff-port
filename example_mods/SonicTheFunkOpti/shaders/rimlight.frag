#pragma header

uniform vec4 rimColor;
uniform float rimAngle;
uniform float rimDistance;

float SAMPLEDIST = 5.0;

vec3 blendMultiply(vec3 base, vec3 blend) {
    return base * blend;
}

vec3 blendOverlay(vec3 base, vec3 blend) {
    return vec3(
        base.r < 0.5 ? 2.0 * base.r * blend.r : 1.0 - 2.0 * (1.0 - base.r) * (1.0 - blend.r),
        base.g < 0.5 ? 2.0 * base.g * blend.g : 1.0 - 2.0 * (1.0 - base.g) * (1.0 - blend.g),
        base.b < 0.5 ? 2.0 * base.b * blend.b : 1.0 - 2.0 * (1.0 - base.b) * (1.0 - blend.b)
    );
}

void main() {
    vec2 uv = openfl_TextureCoordv.xy;
    vec4 baseColor = flixel_texture2D(bitmap, uv);
    vec2 resFactor = 1.0 / openfl_TextureSize.xy;

    float offsetX = cos(rimAngle);
    float offsetY = sin(rimAngle);
    vec2 distMult = (rimDistance * resFactor) / SAMPLEDIST;

    bool isEdge = false;
    float alphaThreshold = 0.1;

    if (baseColor.a > alphaThreshold) {
        for (int i = 1; i <= int(SAMPLEDIST); i++) {
            vec2 offsetUV = uv + vec2(offsetX, offsetY) * distMult * float(i);
            vec4 sample = flixel_texture2D(bitmap, offsetUV);
            if (sample.a < alphaThreshold) {
                isEdge = true;
                break;
            }
        }
    }

    vec3 bodyColor = blendMultiply(baseColor.rgb, vec3(0.525, 0.549, 0.733));

    if (isEdge) {
        vec3 rimLit = blendOverlay(baseColor.rgb, rimColor.rgb);
        gl_FragColor = vec4(rimLit, baseColor.a);
    } else {
        gl_FragColor = vec4(bodyColor, baseColor.a);
    }
}
