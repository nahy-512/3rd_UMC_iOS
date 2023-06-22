//
//  SignUpViewController.swift
//  week7
//
//  Created by 김나현 on 2022/11/07.
//

import UIKit

class SignUpViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Functions
    @IBAction func signupButtonDidTap(_ sender: Any) {
        guard let name = nameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        UserDefaults.standard.set(password, forKey: name)
        
        print("이름: \(name), 비밀번호: \(password)")
        // 이전 화면으로 이동
                self.presentingViewController?.dismiss(animated: true)
//        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cacelButtonDidTap(_ sender: Any) {
        // 이전 화면으로 이동
                self.presentingViewController?.dismiss(animated: true)
//        navigationController?.popViewController(animated: true)
    }
    
}
