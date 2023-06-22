//
//  SecondViewController.swift
//  week3
//
//  Created by 김나현 on 2022/10/04.
//

import UIKit

class SecondViewController: UIViewController {
    
    var resultString = "default 값" // 덧셈의 결과가 담길 예정

    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = resultString
    }

}
