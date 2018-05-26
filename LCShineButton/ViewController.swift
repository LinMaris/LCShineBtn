//
//  ViewController.swift
//  LCShineButton
//
//  Created by 林川 on 2018/5/21.
//  Copyright © 2018年 LinMaris. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var heartBtn: LCShineButton!
    
    @IBOutlet weak var likeBtn: LCShineButton!
    
    @IBOutlet weak var smileBtn: LCShineButton!
    
    @IBOutlet weak var starBtn: LCShineButton!
    
    @IBOutlet weak var customBtn: LCShineButton!
    
    var allBtns = [LCShineButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var param1 = LCShineParams()
        param1.bigShineColor = UIColor(rgb: (153,152,38))
        param1.smallShineColor = UIColor(rgb: (102,102,102))
        heartBtn.params = param1

        var param2 = LCShineParams()
        param2.bigShineColor = UIColor(rgb: (255,95,89))
        param2.smallShineColor = UIColor(rgb: (216,152,148))
        param2.shineCount = 15
        param2.animDuration = 2
        param2.smallShineOffsetAngle = -5
        likeBtn.params = param2
        likeBtn.image = .like
        
        var param3 = LCShineParams()
        param3.allowRandomColor = true
        param3.animDuration = 1
        smileBtn.isSelected = true
        smileBtn.params = param3
        smileBtn.image = .smile
        
        var param4 = LCShineParams()
        param4.enableFlashing = true
        param4.animDuration = 2
        starBtn.params = param4
        starBtn.image = .star
        
        var param5 = LCShineParams()
        param5.bigShineColor = UIColor(rgb: (255, 195, 55))
        customBtn.params = param5
        customBtn.image = .defaultAndSelect(#imageLiteral(resourceName: "collect"), #imageLiteral(resourceName: "collect#"))
        
        allBtns = [heartBtn, likeBtn, smileBtn, starBtn, customBtn]
    }
    
    
    @IBAction func showClick(_ sender: UIButton) {
        
        var delay = 0.0
        for btn in allBtns {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                btn.setClicked(!btn.isSelected, animated: true)
            }
            delay += 0.5
        }
    }
    
    
    @IBAction func btnClick(_ sender: LCShineButton) {
        print("Clicked \(sender.isSelected)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

