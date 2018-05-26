//
//  LCShineTools.swift
//  LCShineButton
//
//  Created by 林川 on 2018/5/21.
//  Copyright © 2018年 LinMaris. All rights reserved.
//

import UIKit

public struct LCShineBundle {
    
    // 当前的bundle
    static var bundle: Bundle {
        let bundle = Bundle(for: LCShineButton.self)
        return bundle
    }
    
    // 存放资源的bundle
    static var lcBundle: Bundle {
        let bundle = Bundle(path: self.bundle.path(forResource: "LCShineButton", ofType: "bundle")!)
        return bundle!
    }
    
    static func imageFromBundle(_ imageName: String) -> UIImage {
        let path = Bundle(path: Bundle(for: LCShineButton.self).path(forResource: "LCShineButton", ofType: "bundle")!)!.bundlePath + "/resource"

        let bundle = Bundle(path: path)
        
//        let bundle = Bundle(path: lcBundle.bundlePath + "/resource")
        
        if let imgPath = bundle?.path(forResource: imageName, ofType: "png") {
            if let image = UIImage(contentsOfFile: imgPath) {
                return image
            }
        }
        return UIImage()
    }
}

extension UIColor {
    public convenience init(rgb: (r: CGFloat, g: CGFloat, b: CGFloat)) {
        self.init(red: rgb.r / 255, green: rgb.g / 255, blue: rgb.b / 255, alpha: 1.0)
    }
}

var isIOS10: Bool {
    if #available(iOS 10.0, *) {
        return true
    }else {
        return false
    }
}

let LCShineDefaultSelectColor = UIColor(rgb: (255, 102, 102))
let LCShineDefaultNormalColor = UIColor.lightGray

