//
//  SecondViewController.swift
//  week4
//
//  Created by 김나현 on 2022/10/11.
//

import UIKit

class SecondViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var textField: UITextField!
    var delegate : labelChangeProtocol? // 이전에 화면이 넘어오기 전에 self를 통해 부모뷰로 초기화한 상태
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Functions
    @IBAction func backButtonDidTab(_ sender: Any) {
        
        guard let text = textField.text else { return }
        
        delegate?.onChange(text: text)
        
        dismiss(animated: true)
    }
    
}
