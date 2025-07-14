void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    // Always start with the base terminal content
    vec4 base = texture(iChannel0, fragCoord.xy / iResolution.xy);
    
    // Normalize coordinates
    vec2 vu = normalize(fragCoord, 1.);
    vec4 currentCursor = vec4(normalize(iCurrentCursor.xy, 1.), normalize(iCurrentCursor.zw, 0.));
    vec4 previousCursor = vec4(normalize(iPreviousCursor.xy, 1.), normalize(iPreviousCursor.zw, 0.));
    
    // Calculate your SDFs
    float sdfCurrentCursor = getSdfRectangle(vu, currentCursor.xy - (currentCursor.zw * vec2(-.5, 0.5)), currentCursor.zw * 0.5);
    
    // Create trail parallelogram (your existing logic)
    float vertexFactor = determineStartVertexFactor(currentCursor.xy, previousCursor.xy);
    float invertedVertexFactor = 1.0 - vertexFactor;

    // Set every vertex of the parallelogram
    vec2 v0 = vec2(currentCursor.x + currentCursor.z * vertexFactor, currentCursor.y - currentCursor.w);
    vec2 v1 = vec2(currentCursor.x + currentCursor.z * invertedVertexFactor, currentCursor.y);
    vec2 v2 = vec2(previousCursor.x + currentCursor.z * invertedVertexFactor, previousCursor.y);
    vec2 v3 = vec2(previousCursor.x + currentCursor.z * vertexFactor, previousCursor.y - previousCursor.w);

    float sdfTrail = getSdfParallelogram(vu, v0, v1, v2, v3);

    // Calculate progress for fade effect
    float progress = clamp((iTime - iTimeCursorChange) / DURATION, 0.0, 1.0);
    float easedProgress = ease(progress);

    // Blend effects onto base
    vec3 result = base.rgb;
    result = mix(result, TRAIL_COLOR.rgb, antialising(sdfTrail) * OPACITY * (1.0 - easedProgress));
    result = mix(result, TRAIL_COLOR.rgb, antialising(sdfCurrentCursor) * OPACITY);

    // Always keep alpha = 1.0 to prevent transparency issues
    fragColor = vec4(result, 1.0);
}
