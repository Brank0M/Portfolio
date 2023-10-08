uniform float time;
uniform float uProgress;
uniform vec2 uResolution;
uniform vec4 uCorners;
uniform vec2 uQuadSize;

varying vec2 vSize;

varying vec2 vUv;

void main() {
    float PI = 3.141592653589793238;
    vUv = uv;
    float sine = sin(PI * uProgress);
    float waves = sine *  0.1 * sin(5.0 * length(uv) + 15.0 * uProgress);
    vec4 defaultState = modelMatrix * vec4(position, 1.0);
    vec4 fullScreenState =  vec4(position, 1.0);
    fullScreenState.x *= uResolution.x;
    fullScreenState.y *= uResolution.y;
    fullScreenState.z += uCorners.x;
    
    float cornersProgress = mix(
        mix(uCorners.z, uCorners.w, uv.x),
        mix(uCorners.x, uCorners.y, uv.x),
        uv.y
    );

    vec4 finalState = mix(defaultState, fullScreenState, cornersProgress);

    vSize = mix(uQuadSize, uResolution, cornersProgress);

    gl_Position = projectionMatrix * viewMatrix * finalState;
}
