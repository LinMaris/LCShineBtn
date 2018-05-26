//
//  LCShineClickLayer.swift
//  LCShineButton
//
//  Created by 林川 on 2018/5/25.
//  Copyright © 2018年 LinMaris. All rights reserved.
//

import UIKit

class LCZoomLayer: CALayer {
    
    var color: UIColor = LCShineDefaultNormalColor
    
    var fillColor: UIColor = LCShineDefaultSelectColor
    
    var animDuration: Double = 1
    
    let maskLayer = CALayer()
    
    var image: LCShineImage = .heart {
        didSet {
            if image.isDefaultAndSelect() {
                mask = nil
                contents = image.getImages().first?.cgImage
            }else {
                maskLayer.contents = image.getImages().first?.cgImage
                mask = maskLayer
            }
        }
    }
    
    var clicked: Bool = false {
        didSet {
            if image.isDefaultAndSelect() {
                backgroundColor = UIColor.clear.cgColor
                contents = clicked ? image.getImages().last?.cgImage :
                image.getImages().first?.cgImage
                
            }else {
                backgroundColor = clicked ? fillColor.cgColor : color.cgColor
            }
        }
    }
    
    /// 缩放动画
    func startAnim() {
        let anim = CAKeyframeAnimation(keyPath: "transform.scale")
        anim.duration = animDuration
        anim.values = [0.4, 1, 0.9, 1]
        anim.calculationMode = kCAAnimationCubic
        if image.isDefaultAndSelect() {
            add(anim, forKey: "scale")
        }else{
            maskLayer.add(anim, forKey: "scale")
        }
    }
    
    override func layoutSublayers() {
        if image.isDefaultAndSelect() {
            backgroundColor = UIColor.clear.cgColor
        }else{
            maskLayer.frame = bounds
            maskLayer.contents = image.getImages().last?.cgImage
            mask = maskLayer
            
            backgroundColor = clicked ? fillColor.cgColor : color.cgColor
        }
    }
    
}
