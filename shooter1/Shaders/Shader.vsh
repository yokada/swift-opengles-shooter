//
//  Shader.vsh
//  shooter1
//
//  Created by Yoji Okada on 2016/05/22.
//  Copyright © 2016年 Yoji Okada. All rights reserved.
//


// バーテックスシェーダへの入力
attribute vec4 position;
attribute vec4 color;
attribute vec2 texCoord;

// フラグメントシェーダへの出力
varying vec4 vColor;
varying vec2 vTexCoord;

// 入力した頂点座標、頂点色、テクスチャ座標をそのまま出力
void main() {
    gl_Position = position;
    vColor = color;
    vTexCoord = texCoord;
}