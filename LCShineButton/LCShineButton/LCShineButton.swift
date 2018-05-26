//
//  LCShineButton.swift
//  LCShineButton
//
//  Created by 林川 on 2018/5/21.
//  Copyright © 2018年 LinMaris. All rights reserved.
//

import UIKit

@IBDesignable  // 让你的自定 UIView 可以在 IB 中预览
public class LCShineButton: UIControl {
    
    /// 配置参数
    public var params: LCShineParams {
        didSet {
            zoomLayer.animDuration = params.animDuration * 0.35
            shineLayer.params = params
        }
    }
    
    /// 未点击的颜色
    @IBInspectable public var color: UIColor = UIColor.lightGray {
        willSet {
            zoomLayer.color = newValue
        }
    }
    
    /// 点击后的颜色   // 让你的自定义 UIView 的属性出现在 IB 中 Attributes inspector
    @IBInspectable public var fillColor: UIColor = LCShineDefaultSelectColor {
        willSet {
            zoomLayer.fillColor = newValue
            shineLayer.fillColor = newValue
        }
    }
    
    /// button 的图片
    public var image: LCShineImage = .heart {
        willSet {
            zoomLayer.image = newValue
        }
    }
    
    /// 是否点击的状态
    public override var isSelected: Bool {
        didSet {
            zoomLayer.clicked = isSelected
        }
    }
    
    private var zoomLayer = LCZoomLayer()
    
    private var shineLayer = LCShineLayer()
    
    public init(frame: CGRect, params: LCShineParams) {
        self.params = params
        super.init(frame: frame)
        initLayers()
    }
    
    public override init(frame: CGRect) {
        params = LCShineParams()
        super.init(frame: frame)
        initLayers()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        params = LCShineParams()
        super.init(coder: aDecoder)
        layoutIfNeeded()
        initLayers()
    }
    
    private func initLayers() {
        zoomLayer.animDuration = params.animDuration * 0.35
        zoomLayer.frame = bounds
        layer.addSublayer(zoomLayer)
        
        shineLayer.params = params
        shineLayer.frame  = bounds
        layer.addSublayer(shineLayer)
    }
    
    public func setClicked(_ clicked: Bool, animated: Bool) {
        if clicked == zoomLayer.clicked {
            return
        }
        
        if clicked {
            shineLayer.endAnim = {
                animated ? self.zoomLayer.startAnim() : nil
            }
            animated ? shineLayer.startAnim() : shineLayer.endAnim?()
        }
        
        zoomLayer.clicked = clicked
        isSelected = clicked
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        if zoomLayer.clicked == false {
            
            shineLayer.endAnim = {
                self.zoomLayer.startAnim()
            }
            shineLayer.startAnim()
        }
        zoomLayer.clicked = !zoomLayer.clicked
        isSelected = zoomLayer.clicked
        sendActions(for: .valueChanged)
        
    }
    
}
