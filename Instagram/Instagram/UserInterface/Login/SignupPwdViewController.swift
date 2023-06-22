//
//  SignupPwdViewController.swift
//  Instagram
//
//  Created by 김나현 on 2022/11/27.
//

import UIKit

class SignupPwdViewController: UIViewController { // #4

    // MARK: - Properties
    static let identifier = "SignupVC3"
    let buttonColor = UIColor(named: "ButtonColor")
    
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var savePwdCheckButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var pwdIsSaved = true
    
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
        
        // 비밀번호 저장
        let savePwd = pwdTextField.text
        UserDefaults.standard.set(savePwd, forKey: "signupPwd")
        print(UserDefaults.standard.string(forKey: "signupPwd"))
    }
    
    
    // MARK: - Functions
    
    // textField 입력 여부 확인
    func textFieldDidEdit() {
        pwdTextField.addTarget(self, action: #selector(checkTextFieldFilled), for: .editingChanged)
    }
    
    @objc func checkTextFieldFilled() {
        if (pwdTextField.text != "") {
            // 버튼 활성화
            nextButton.tintColor = .tintColor
            nextButton.isUserInteractionEnabled = true
        } else {
            // 버튼 비활성화
            nextButton.tintColor = buttonColor
            nextButton.isUserInteractionEnabled = false
        }
    }
    
    
    @IBAction func pwdSaveBtnDidTap(_ sender: Any) {
        if (pwdIsSaved) {
            print("비밀번호 저장 체크 해제")
            savePwdCheckButton.setImage(UIImage(systemName: "square"), for: .normal)
            pwdIsSaved = false
        }
        else {
            print("비밀번호 저장 체크")
            savePwdCheckButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            pwdIsSaved = true
        }
    }
    
    @IBAction func nextBtnDidTap(_ sender: Any) {
        print("다음 버튼 클릭")
        guard let nextVC = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: SignupUIdViewController.identifier) as?
                SignupUIdViewController else { return }
        
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
