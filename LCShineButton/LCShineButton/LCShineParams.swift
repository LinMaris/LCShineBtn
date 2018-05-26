//
//  LCShineParams.swift
//  LCShineButton
//
//  Created by 林川 on 2018/5/21.
//  Copyright © 2018年 LinMaris. All rights reserved.
//

import UIKit

public struct LCShineParams
{
    /// shine是否随机颜色
    public var allowRandomColor: Bool = false
    /// shine动画时间，秒
    public var animDuration: Double = 1
    /// 大Shine的颜色
    public var bigShineColor: UIColor = UIColor(rgb: (255, 102, 102))
    /// 小shine的颜色
    public var smallShineColor: UIColor = .lightGray
    /// shine的个数
    public var shineCount: Int = 7
    /// shine的大小
    public var shineSize: CGFloat = 0
    /// shine的扩散的旋转角度
    public var shineTurnAngle: Float = 20
    /// shine的扩散的范围的倍数
    public var shineDistanceMultiple: Float = 1.5
    /// 小shine与大shine之前的角度差异
    public var smallShineOffsetAngle: Float = 20
    /// 是否需要Flash效果
    public var enableFlashing: Bool = false
    /// 随机的颜色列表
    public var colorRandom: [UIColor] = [UIColor(rgb: (255, 255, 153)),
                                         UIColor(rgb: (255, 204, 204)),
                                         UIColor(rgb: (153, 102, 153)),
                                         UIColor(rgb: (255, 102, 102)),
                                         UIColor(rgb: (255, 255, 102)),
                                         UIColor(rgb: (244, 67, 54)),
                                         UIColor(rgb: (102, 102, 102)),
                                         UIColor(rgb: (204, 204, 0)),
                                         UIColor(rgb: (102, 102, 102)),
                                         UIColor(rgb: (153, 153, 51))];
}

/// 图片选择的枚举
///
/// - heart: 心形
/// - like: 点赞
/// - smile: 微笑
/// - star: 星星
/// - custom: 自定义图片
/// - defaultAndSelect: 自定义默认和选中的图片
public enum LCShineImage {
    
    case heart
    case like
    case smile
    case star
    case custom(UIImage)
    case defaultAndSelect(UIImage, UIImage)
    
    func getImages() -> [UIImage] {
        switch self {
        case .heart:
            return [LCShineBundle.imageFromBundle("heart")]
        case .like:
            return [LCShineBundle.imageFromBundle("like")]
        case .smile:
            return [LCShineBundle.imageFromBundle("smile")]
        case .star:
            return [LCShineBundle.imageFromBundle("star")]
        case .custom(let image):
            return [image]
        case .defaultAndSelect(let defaultImage, let selectImage):
            return [defaultImage, selectImage]
        }
    }
    
    func getValues() -> Int {
        switch self {
        case .heart:
            return 0
        case .like:
            return 1
        case .smile:
            return 2
        case .star:
            return 3
        case .custom(_):
            return 4
        case .defaultAndSelect(_, _):
            return 5
        }
    }
    
    func isDefaultAndSelect() -> Bool {
        return getValues() == 5
    }
}



