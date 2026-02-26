#pragma header

uniform float iTime;
uniform vec2 iResolution;

float rand(float x) {
    return fract(sin(x * 17.0) * 43758.5453123);
}

void main() {
    vec2 uv = openfl_TextureCoordv;

    float sliceHeight = 0.08;       // Space between distortion chunks
    float speed = 0.1;              // Upward scroll speed
    float maxOffset = 0.004;        // Base distortion strength

    // Subtle wave parameters
    float waveAmplitude = 0.002;   // How strong the wave is
    float waveFrequency = 40.0;     // How many wiggles vertically
    float waveSpeed = 1;          // How fast the wave animates

    // Upward-moving distortion offset per slice
    float movingY = mod(uv.y + iTime * speed, 1.0);
    float slice = floor(movingY / sliceHeight);
    float chunkOffset = rand(slice) * maxOffset;

    // Add a subtle wave on top
    float waveOffset = sin((uv.y * waveFrequency) + (iTime * waveSpeed)) * waveAmplitude;

    // Combine both offsets
    vec2 distortedUV = vec2(uv.x + chunkOffset + waveOffset, uv.y);
    gl_FragColor = texture2D(bitmap, distortedUV);
}
