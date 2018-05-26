//
//  LCShineLayer.swift
//  LCShineButton
//
//  Created by 林川 on 2018/5/25.
//  Copyright © 2018年 LinMaris. All rights reserved.
//

import UIKit

class LCShineLayer: CALayer, CAAnimationDelegate {
    
    /// 用来绘制圆环
    let shapeLayer = CAShapeLayer()
    
    var fillColor: UIColor = LCShineDefaultSelectColor
    
    var params: LCShineParams = LCShineParams()
    
    var displaylink: CADisplayLink?
    
    var endAnim: (() -> ())?
    
    /// 圆环扩散动画
    func startAnim() {
        let anim = CAKeyframeAnimation(keyPath: "path")
        anim.duration = params.animDuration * 0.1
        let size = frame.size
        let fromPath = UIBezierPath(arcCenter:
            CGPoint(x: size.width / 2, y: size.height / 2),
            radius: 1,
            startAngle: 0,
            endAngle: CGFloat(Double.pi * 2),
            clockwise: false).cgPath
        let toPath = UIBezierPath(arcCenter:
            CGPoint(x: size.width / 2, y: size.height / 2),
            radius: size.width / 2 * CGFloat(params.shineDistanceMultiple),
            startAngle: 0,
            endAngle: CGFloat(Double.pi * 2),
            clockwise: false).cgPath
        anim.delegate = self
        anim.values = [fromPath, toPath]
        anim.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
        anim.isRemovedOnCompletion = false
        anim.fillMode = kCAFillModeForwards
        shapeLayer.add(anim, forKey: "path")
        if params.enableFlashing {   // 是否开启闪烁
            startFlash()
        }
    }
    
    override init() {
        super.init()
        initLayers()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
        initLayers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initLayers() {
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.strokeColor = fillColor.cgColor
        shapeLayer.lineWidth = 1.5
        addSublayer(shapeLayer)
    }
    
    /// 开始闪烁
    private func startFlash() {
        displaylink = CADisplayLink(target: self, selector: #selector(flashAction))
    }
    
    @objc private func flashAction() {
        let index = Int(arc4random()%UInt32(params.colorRandom.count))
        shapeLayer.strokeColor = params.colorRandom[index].cgColor
    }
    
    //MARK: CAAnimationDelegate
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            displaylink?.invalidate()
            displaylink = nil
            shapeLayer.removeAllAnimations()
            
            // 圆盘动画
            let angleLayer = LCAngleLayer(frame: bounds, params: params)
            addSublayer(angleLayer)
            angleLayer.startAnim()
            
            // 动画结束后调用
            endAnim?()
        }
    }
    
}
