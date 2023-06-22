//
//  ViewController.swift
//  week7
//
//  Created by 김나현 on 2022/11/07.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
    
    // MARK: - Functions
    
    @IBAction func loginButtonDidTap(_ sender: Any) {
        guard let name = nameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        if  UserDefaults.standard.string(forKey: name) == nil {
            print("데이터가 없습니다.")
        }
        else if password != UserDefaults.standard.string(forKey: name) {
            print("비밀번호가 알맞지 않습니다.")
        } else  {
            print("로그인 성공!")
        }
    }
    
    @IBAction func signupButtonDidTap(_ sender: Any) {
        print("회원가입 버튼 클릭")
        guard let presentedViewController = UIStoryboard(name:
                    "Main", bundle: nil)
                    .instantiateViewController(withIdentifier: "SignUpViewController") as?
                    SignUpViewController else { return }

                // 화면 전환
                present(presentedViewController, animated: true)
        
//        guard let signupViewController =
//                UIStoryboard(name: "Main", bundle: nil)
//            .instantiateViewController(withIdentifier: "SignUpViewController") as?
//                SignUpViewController else { return }
//
//        // 화면 전환
//        navigationController?
//            .pushViewController(signupViewController, animated: true)
    }
}

