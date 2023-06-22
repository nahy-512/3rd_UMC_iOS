//
//  SignupEmailViewController.swift
//  Instagram
//
//  Created by 김나현 on 2022/11/27.
//

import UIKit

class SignupEmailViewController: UIViewController, UITextFieldDelegate { // #2

    // MARK: - Properties
    static let identifier = "SignupVC1"
    let buttonColor = UIColor(named: "ButtonColor")
    
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 버튼 비활성화
        nextButton.tintColor = buttonColor
        nextButton.isUserInteractionEnabled = false
        
        // textField 상태 체크
        textFieldDidEdit()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    

    // MARK: - Functions
    
    // textField 입력 여부 확인
    func textFieldDidEdit() {
        emailAddressTextField.addTarget(self, action: #selector(checkTextFieldFilled), for: .editingChanged)
    }
    
    @objc func checkTextFieldFilled() {
        if (emailAddressTextField.text != "") {
            // 버튼 활성화
            nextButton.tintColor = .tintColor
            nextButton.isUserInteractionEnabled = true
        } else {
            nextButton.tintColor = buttonColor
            nextButton.isUserInteractionEnabled = false
        }
    }
    
    @IBAction func backBtnDidTap(_ sender: Any) { // 뒤로가기
        print("뒤로가기 버튼 클릭")
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func nextBtnDidTap(_ sender: Any) { // 다음
        print("다음 버튼 클릭")
        // 이메일 정보 저장
        let saveEmail = emailAddressTextField.text
        UserDefaults.standard.setValue(saveEmail, forKey: "signupEmail")
        print(UserDefaults.standard.string(forKey: "signupEmail"))
        
        guard let nextVC = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: SignupAddNameViewController.identifier) as?
        SignupAddNameViewController else { return }
        
        // 화면 전환
//        navigationController?.pushViewController(nextVC, animated: true)
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.modalTransitionStyle = .crossDissolve
        present(nextVC, animated: true)
    }
    
    @IBAction func loginBtnDidTap(_ sender: Any) { // 로그인
        //self.navigationController?.popToRootViewController(animated: true)
        
        guard let loginVC = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: LoginViewController.identifier) as?
                LoginViewController else { return }
        // 화면 전환
        loginVC.modalPresentationStyle = .fullScreen
        loginVC.modalTransitionStyle = .crossDissolve
        present(loginVC, animated: true)
    }
}
