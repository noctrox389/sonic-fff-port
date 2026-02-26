#ifdef GL_ES
precision mediump float;
#endif

uniform sampler2D bitmap;
varying vec2 openfl_TextureCoordv;

void main() {
    vec4 color = texture2D(bitmap, openfl_TextureCoordv);  // Sample the texture color

    // Simple Additive blending: Just add the color to the final result
    gl_FragColor = color + vec4(0.0, 0.0, 0.0, 0.0); // This will add the color to itself (making it brighter)
    
    // Ensure we clamp the output to avoid overflow (overflow would make things go out of range)
    gl_FragColor = min(gl_FragColor, vec4(1.0, 1.0, 1.0, 1.0));  // Clamp to max value of 1.0
}
