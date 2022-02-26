//
//  Coffee.swift
//  WeekPractice-CoreAnimation
//
//  Created by 양호준 on 2022/02/26.
//

import UIKit

class Coffee: UIView {
    func drawCup() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: frame.width * 0.15, y: frame.height * 0.2))
        path.addLine(to: CGPoint(
            x: frame.width * 0.25,
            y: frame.height * 0.7)
        )
        path.addCurve(
            to: CGPoint(
                x: frame.width * 0.75, y: frame.height * 0.7),
            controlPoint1: CGPoint(x: frame.width * 0.3, y: frame.height * 0.8),
            controlPoint2: CGPoint(x: frame.width * 0.75, y: frame.height * 0.8)
        )
        path.addLine(to: CGPoint(
            x: frame.width * 0.85,
            y: frame.height * 0.2)
        )
        
        let layer = CAShapeLayer()
        layer.frame = bounds
        layer.path = path.cgPath
        layer.strokeColor = UIColor.systemGray.cgColor
        layer.fillColor = UIColor.clear.cgColor
    
        layer.lineWidth = 15
        self.layer.addSublayer(layer)
    }
    
    func drawStraw() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: frame.width * 0.95, y: frame.height * 0.1))
        path.addLine(to: CGPoint(x: frame.width * 0.8, y: frame.height * 0.2))
        path.addLine(to: CGPoint(x: frame.width * 0.27, y: frame.height * 0.7))
        
        let layer = CAShapeLayer()
        layer.frame = bounds
        layer.path = path.cgPath
        layer.strokeColor = UIColor.black.cgColor
    }
    
    override func layoutMarginsDidChange() { // bounds가 변하는 것을 감지. Rect가 갱신될 때마다 호출.
        self.backgroundColor = .white
        drawCup()
    }
}

// shift + cmd + a -> 다크모드
