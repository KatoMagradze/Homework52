//
//  ViewController.swift
//  Homework52
//
//  Created by Kato on 6/30/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var midViewX = CGFloat()
    var midViewY = CGFloat()

    var circlePath2 = UIBezierPath()
    var ballLayer = CAShapeLayer()
    
    let degreeLabel: UILabel = UILabel()
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        let redColor = hexStringToUIColor(hex: "#b01b10")
        
        midViewX = view.frame.midX
        midViewY = view.frame.midY
       
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: midViewX,y: midViewY), radius: 100, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        
        
        degreeLabel.frame = CGRect(x: view.center.x - 200/2, y: view.center.y - 10, width: 200, height: 20)
        //degreeLabel.backgroundColor = UIColor.orange
        degreeLabel.textColor = UIColor.black
        degreeLabel.textAlignment = NSTextAlignment.center
        degreeLabel.text = "0.0"
        degreeLabel.font = UIFont.boldSystemFont(ofSize: 25)
        self.view.addSubview(degreeLabel)
        
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = redColor.cgColor
        circleLayer.lineWidth = 18.0
        view.layer.addSublayer(circleLayer)

        let angleEarth: Double = 180
        let angleEarthAfterCalculate: CGFloat = CGFloat(angleEarth*Double.pi/180) - CGFloat(Double.pi/2)
        let earthX = midViewX + cos(angleEarthAfterCalculate)*100
        let earthY = midViewY + sin(angleEarthAfterCalculate)*100
        circlePath2 = UIBezierPath(arcCenter: CGPoint(x: earthX,y: earthY), radius: CGFloat(10), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        ballLayer.path = circlePath2.cgPath
        ballLayer.fillColor = UIColor.black.cgColor
        ballLayer.strokeColor = UIColor.clear.cgColor
        ballLayer.lineWidth = 7
        view.layer.addSublayer(ballLayer)

        let dragBall = UIPanGestureRecognizer(target: self, action:#selector(dragBall(recognizer:)))
        view.addGestureRecognizer(dragBall)

    }

    @objc func dragBall(recognizer: UIPanGestureRecognizer) {
        
        let point = recognizer.location(in: self.view);
        let earthX = Double(point.x)
        let earthY = Double(point.y)
        let midViewXDouble = Double(midViewX)
        let midViewYDouble = Double(midViewY)
        let angleX = (earthX - midViewXDouble)
        
        degreeLabel.text = "\(angleX)"
        
        //print(angleX)
        
        let angleY = (earthY - midViewYDouble)
        //print(angleY)
        
        //inverse tangent of two variables
        let angle = atan2(angleY, angleX)
        
        let earthX2 = midViewXDouble + cos(angle)*100
        let earthY2 = midViewYDouble + sin(angle)*100
        
        circlePath2 = UIBezierPath(arcCenter: CGPoint(x: earthX2,y: earthY2), radius: 10, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        
        ballLayer.path = circlePath2.cgPath
        
    }
}

extension ViewController {
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}

