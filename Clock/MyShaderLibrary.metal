//
//  MyShaderLibrary.metal
//  Clock
//
//  Created by windowcow on 3/20/24.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;


[[ stitchable ]] half4 makeBlack(float2 position, SwiftUI::Layer layer) {
    return half4(0, 0, 0, 1);
}

