//
//  Monochrome.metal
//  LocalChat
//
//  Created by Егор Никитин on 10/2/24.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] half4 monochrome
(
 float2 position,
 half4 color
 ) {
    half v = (color.r + color.g + color.b) / 3.0;
    return half4(v, v, v, 1.0);
}
