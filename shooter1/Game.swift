//
//  Game.swift
//  shooter1
//
//  Created by Yoji Okada on 2016/05/23.
//  Copyright © 2016年 Yoji Okada. All rights reserved.
//

import Foundation
import GLKit
import OpenGLES

var gProgram: GLuint = 0
var gContext:EAGLContext? = nil
var gUniformTexture: GLint = 0

class Game {
    init(){
        glEnable(GLenum(GL_BLEND))
    }
}
