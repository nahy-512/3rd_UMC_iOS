//
//  ViewController.swift
//  week4
//
//  Created by 김나현 on 2022/10/11.
//

import UIKit

protocol labelChangeProtocol {
    func onChange(text: String)
}

class ViewController: UIViewController, labelChangeProtocol {
    
    
    // MARK: - Properties
    @IBOutlet weak var label: UILabel!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - functions
    func onChange(text: String) {
        label.text = text
    }
    
    @IBAction func buttonDidTab(_ sender: Any) {
        // 다음 뷰로 화면 전환
        guard let SecondViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondVC") as? SecondViewController else { return }
        
        SecondViewController.modalPresentationStyle = .fullScreen
        
        
        SecondViewController.delegate = self // present 되기 전에 자식뷰에 있는 delegate 변수를 여기서 초기화
        
        present(SecondViewController, animated: true)
    }
    
    
    
}

