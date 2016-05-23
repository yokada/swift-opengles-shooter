//
//  Shader.fsh
//  shooter1
//
//  Created by Yoji Okada on 2016/05/22.
//  Copyright © 2016年 Yoji Okada. All rights reserved.
//

// texture sampler
uniform sampler2D texture;

// フラグメントシェーダーへの入力
varying lowp vec4 vColor;
varying lowp vec2 vTexCoord;

void main()  {
    gl_FragColor = vColor*texture2D(texture, vTexCoord);
}