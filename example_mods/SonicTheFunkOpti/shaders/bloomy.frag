#pragma header

uniform float iTime;
uniform float bloomStrength;
uniform float threshold;
uniform vec2 resolution;

void main() {
    // Get the texture coordinates
    vec2 uv = openfl_TextureCoordv;

    // Get the size of one texel (pixel) in the texture
    vec2 texelSize = vec2(1.0) / resolution;

    // Sample the texture at the current coordinates
    vec4 color = texture2D(bitmap, uv);

    // Compute brightness of the pixel to apply threshold for bloom
    float brightness = max(max(color.r, color.g), color.b);
    if (brightness < threshold) {
        gl_FragColor = color; // No bloom effect on dark pixels
        return;
    }

    // Bloom effect: apply a simple blur around the current pixel
    vec4 bloomColor = vec4(0.0);

    // Sample surrounding pixels for the bloom effect
    float bloomRadius = 3.0;  // radius of the blur
    for (float x = -bloomRadius; x <= bloomRadius; x++) {
        for (float y = -bloomRadius; y <= bloomRadius; y++) {
            vec2 offset = vec2(x, y) * texelSize;
            bloomColor += texture2D(bitmap, uv + offset);
        }
    }

    // Normalize the bloom color
    bloomColor /= (bloomRadius * 2.0 + 1.0) * (bloomRadius * 2.0 + 1.0);

    // Apply the bloom color to the original color
    bloomColor *= bloomStrength;

    // Final output: combine the original color with the bloom
    gl_FragColor = color + bloomColor;
}
