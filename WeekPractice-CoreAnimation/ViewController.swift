//
//  ViewController.swift
//  WeekPractice-CoreAnimation
//
//  Created by 양호준 on 2022/02/26.
//

import UIKit

class ViewController: UIViewController {
//    @IBOutlet weak var coffeeView: Coffee!
    let coffeeView = Coffee()
    
    override func loadView() {
        view = coffeeView
    }

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        coffeeView.backgroundColor = .systemGray6
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        coffeeView.drawCup()
//    }
    

    // Rect가 결정되는 시점은 보통 ViewWillAppear에서 됨.
    // 연산이 끝난 시점이 ViewDidAppear
}

