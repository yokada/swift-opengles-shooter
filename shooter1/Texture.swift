//
//  HPTexture.swift
//  shooter1
//
//  Created by Yoji Okada on 2016/05/23.
//  Copyright © 2016年 Yoji Okada. All rights reserved.
//

import UIKit
import GLKit
import OpenGLES
import Foundation

class Texture {
    var texture: GLuint = 0
    let screenWidth: GLfloat = 1.0
    let screenHeight: GLfloat = 1.5
    
    init(file: String) {
        let img = UIImage(named: file)!.CGImage

        // Retreive image size from width and height.
        let w = CGImageGetWidth(img)
        let h = CGImageGetHeight(img)
        
        // Allocate memories for a texture.
        let data = calloc(1, w*h*4)
        
        // Create context in order to render image on memory spaces
        let context = CGBitmapContextCreate(data, w, h, 8, w*4, CGImageGetColorSpace(img), CGImageAlphaInfo.PremultipliedLast.rawValue)
        
        // Draw image via context
        CGContextDrawImage(context, CGRectMake(0, 0, CGFloat(w), CGFloat(h)), img)
        
        // Free context: unnecessary call
        //CGContextRelease(context)
        
        
        // Generate a texture
        glGenTextures(1, &texture)
        // Bind a texture
        glBindTexture(GLenum(GL_TEXTURE_2D), texture)
        
        // 
        glTexParameterf(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_MAG_FILTER), GLfloat(GL_LINEAR))
        glTexParameterf(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_MIN_FILTER), GLfloat(GL_LINEAR))
        
        // Populate memories as texture
        glTexImage2D(GLenum(GL_TEXTURE_2D), 0, GLint(GL_RGBA), GLsizei(w), GLsizei(h), 0, GLenum(GL_RGBA), GLenum(GL_UNSIGNED_BYTE), data)

        free(data)
    }
    
    deinit {
        if (texture != 0) {
            glDeleteTextures(1, &texture)
        }
    }
    
    func draw(x: GLfloat, y: GLfloat, w: GLfloat, h: GLfloat, r: GLfloat, g: GLfloat, b: GLfloat, a: GLfloat) {
        let x = x / screenWidth
        let y = y / screenHeight
        let w = w / screenWidth
        let h = h / screenHeight
        
        let positions: [GLfloat] = [
            x-w, y-h, x+w, y-h, x-w, y+h, x+w, y+h
        ]
        
        let colors: [GLfloat] = [
            r, g, b, a, r, g, b, a, r, g, b, a, r, g, b, a
        ]
        
        let texCoords: [GLfloat] = [
            0.0, 1.0, 1.0, 1.0, 0.0, 0.0, 1.0, 0.0
        ]

        gUniformTexture = glGetUniformLocation(gProgram, "texture")  // "texture" is uniform name you defined at Shader.fsh

        glEnable(GLenum(GL_BLEND))
        glEnable(GLenum(GL_TEXTURE_2D))
        glBlendFunc(GLenum(GL_SRC_ALPHA), GLenum(GL_ONE_MINUS_SRC_ALPHA))

        glUseProgram(gProgram)
        glUniform1i(gUniformTexture, 0)
        glVertexAttribPointer(0, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, positions)
        glVertexAttribPointer(1, 4, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, colors)
        glVertexAttribPointer(2, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, texCoords)
        glValidateProgram(gProgram)

        glActiveTexture(GLenum(GL_TEXTURE0))
        glBindTexture(GLenum(GL_TEXTURE_2D), texture)
        glDrawArrays(GLenum(GL_TRIANGLE_STRIP), 0, 4)
        
        
    }
}
