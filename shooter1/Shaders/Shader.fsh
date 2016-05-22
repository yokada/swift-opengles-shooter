//
//  Shader.fsh
//  shooter1
//
//  Created by Yoji Okada on 2016/05/22.
//  Copyright © 2016年 Yoji Okada. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
