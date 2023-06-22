//
//  SignupAddNameViewController.swift
//  Instagram
//
//  Created by 김나현 on 2022/11/27.
//

import UIKit

class SignupAddNameViewController: UIViewController { // #3

    // MARK: - Properties
    static let identifier = "SignupVC2"
    let buttonColor = UIColor(named: "ButtonColor")
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // 버튼 비활성화
        nextButton.tintColor = buttonColor
        nextButton.isUserInteractionEnabled = false
        
        // TextField 상태 체크
        textFieldDidEdit()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    // MARK: - Functions
    
    // textField 입력 여부 확인
    func textFieldDidEdit() {
        nameTextField.addTarget(self, action: #selector(checkTextFieldFilled), for: .editingChanged)
    }
    
    @objc func checkTextFieldFilled() {
        if (nameTextField.text != "") {
            // 버튼 활성화
            nextButton.tintColor = .tintColor
            nextButton.isUserInteractionEnabled = true
        } else {
            // 버튼 비활성화
            nextButton.tintColor = buttonColor
            nextButton.isUserInteractionEnabled = false
        }
    }
    
    @IBAction func nextBtnDidTap(_ sender: Any) {
        print("다음 버튼 클릭")
        // 이름 저장
        let saveName = nameTextField.text
        UserDefaults.standard.set(saveName, forKey: "signupName")
        print(UserDefaults.standard.string(forKey: "signupName"))
        
        guard let nextVC = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: SignupPwdViewController.identifier) as?
                SignupPwdViewController else { return }
        
        // 화면 전환
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.modalTransitionStyle = .crossDissolve
        present(nextVC, animated: true)
    }
    
    @IBAction func loginBtnDidTap(_ sender: Any) {
        guard let loginVC = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: LoginViewController.identifier) as?
                LoginViewController else { return }
        // 화면 전환
        loginVC.modalPresentationStyle = .fullScreen
        loginVC.modalTransitionStyle = .crossDissolve
        present(loginVC, animated: true)
        
        //self.navigationController?.popToRootViewController(animated: true)
    }
    
}
