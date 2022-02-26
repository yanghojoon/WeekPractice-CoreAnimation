//
//  Coffee.swift
//  WeekPractice-CoreAnimation
//
//  Created by 양호준 on 2022/02/26.
//

import UIKit

final class Coffee: UIView {
    let tapGestureRecognizer = UITapGestureRecognizer()
    private let cupLayer = CAShapeLayer()
    private let coffeeLayer = CAShapeLayer()
    private let strawLayer = CAShapeLayer()
    private let leftCoffeeLayer = CAShapeLayer()
    private var isFilled: Bool = true
    
    private func makeCoffeeCupPath() -> UIBezierPath {
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
        
        return path
    }
    
    private func drawCup() {
        let path = makeCoffeeCupPath()
        
        cupLayer.frame = bounds
        cupLayer.path = path.cgPath
        cupLayer.strokeColor = UIColor.systemGray.cgColor
        cupLayer.fillColor = UIColor.clear.cgColor
        cupLayer.lineWidth = 15
        cupLayer.masksToBounds = false
        
        layer.addSublayer(cupLayer)
    }
    
    private func drawStraw() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: frame.width * 0.95, y: frame.height * 0.1))
        path.addLine(to: CGPoint(x: frame.width * 0.75, y: frame.height * 0.2))
        path.addLine(to: CGPoint(x: frame.width * 0.3, y: frame.height * 0.7))
        
        strawLayer.frame = bounds
        strawLayer.path = path.cgPath
        strawLayer.strokeColor = UIColor.black.cgColor
        strawLayer.fillColor = UIColor.clear.cgColor
        strawLayer.lineWidth = 15
        strawLayer.lineCap = .round
        
        layer.addSublayer(strawLayer)
    }
    
    private func drawCoffee() {
        let path = makeCoffeeCupPath()

        coffeeLayer.frame = bounds
        coffeeLayer.path = path.cgPath
        coffeeLayer.fillColor = UIColor.brown.cgColor
        coffeeLayer.lineWidth = 15
        coffeeLayer.strokeColor = UIColor.clear.cgColor
        coffeeLayer.mask = leftCoffeeLayer
        
        layer.addSublayer(coffeeLayer)
    }
    
    private func drawLeftCoffee() {
        let maskingRectangle = CGRect(x: .zero, y: frame.height * 0.3, width: frame.width, height: frame.height)
        
        leftCoffeeLayer.frame = bounds
        leftCoffeeLayer.path = UIBezierPath(rect: maskingRectangle).cgPath
    }
    
    override func layoutMarginsDidChange() { // bounds가 변하는 것을 감지. Rect가 갱신될 때마다 호출.
        backgroundColor = .systemBackground
        tapGestureRecognizer.delegate = self
        addGestureRecognizer(tapGestureRecognizer)
        
        drawStraw()
        drawLeftCoffee()
        drawCoffee()
        drawCup()
    }
}

// shift + cmd + a -> 다크모드
// mask로 보이고 싶은 부분을 정의한다.
extension Coffee: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive event: UIEvent) -> Bool {
        print("터치됐다")
        let positionYAnimation = CABasicAnimation(keyPath: "position.y")
//        strawLayer.transform = CATransform3DMakeRotation(0, 0, 0, 1.0)

        if isFilled {
            positionYAnimation.fromValue = frame.height * 0.5
            positionYAnimation.toValue = frame.height
            positionYAnimation.duration = 1.0
            UIView.animate(withDuration: 500.0) {
                self.strawLayer.transform = CATransform3DMakeRotation(-.pi/24, 0, 0, 1.0)
            }
//            strawLayer.transform = CATransform3DMakeRotation(-.pi/24, 0, 0, 1.0)
            isFilled = false
        } else {
            positionYAnimation.fromValue = frame.height
            positionYAnimation.toValue = frame.height * 0.5
            positionYAnimation.duration = 1.0
            UIView.animate(withDuration: 5.0) {
                self.strawLayer.transform = CATransform3DMakeRotation(0, 0, 0, 1.0)
            }
//            strawLayer.transform = CATransform3DMakeRotation(0, 0, 0, 1.0)
            isFilled = true
        }
        
        positionYAnimation.fillMode = .forwards
        positionYAnimation.isRemovedOnCompletion = false
        leftCoffeeLayer.add(positionYAnimation, forKey: nil)
        
        return true
    }
}
