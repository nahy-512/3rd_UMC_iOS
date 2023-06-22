//
//  LoginViewController.swift
//  Instagram
//
//  Created by 김나현 on 2022/11/25.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController, UITextFieldDelegate { // #1
    
    // MARK: - Properties
    static let identifier = "LoginVC"
    let buttonColor = UIColor(named: "ButtonColor")
    
    @IBOutlet weak var loginIdTextField: UITextField!
    @IBOutlet weak var loginPwdTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var clearIdButton: UIButton! // x버튼
    @IBOutlet weak var pwdVisibleButton: UIButton!
    @IBOutlet weak var loginErrorLabel: UILabel!
    
    var isVisible = false // 비밀번호 표시 여부
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginIdTextField.delegate = self
        loginPwdTextField.delegate = self
        
        setInitialUI()
        textFieldDidEdit()
    }
    
    
    // MARK: - Functions
    
    func login() { // 사용자 확인 메커니즘
        guard let savedId = UserDefaults.standard.string(forKey: "signupId") else { return }
        guard let savedPwd = UserDefaults.standard.string(forKey: "signupPwd") else { return }
        
        if (loginIdTextField.text == savedId) {
            if (loginPwdTextField.text == savedPwd) { // 로그인 성공
                print("로그인 성공!!")
                
                // 화면 전환
                guard let mainVC = UIStoryboard(name: "Main", bundle: nil)
                    .instantiateViewController(withIdentifier: "TabBarController") as?
                        TabBarController else { return }
                
                mainVC.modalPresentationStyle = .fullScreen
                mainVC.modalTransitionStyle = .crossDissolve
                
                present(mainVC, animated: true)
            }
            else { // 비밀번호 오류
                print("비밀번호 오류.")
                loginErrorLabel.text = "비밀번호 오류."
                loginIdTextField.layer.borderColor = UIColor.clear.cgColor
                // 에러 메시지 표시
                loginErrorLabel.isHidden = false
                loginPwdTextField.layer.borderWidth = 1
                loginPwdTextField.layer.cornerRadius = 5
                loginPwdTextField.layer.borderColor = UIColor.red.cgColor
            }
        }
        else { // 사용자 이름 오류
            print("사용자 이름 오류.")
            loginErrorLabel.text = "사용자 이름 오류."
            loginPwdTextField.layer.borderColor = UIColor.clear.cgColor
            // 에러 메시지 표시
            loginErrorLabel.isHidden = false
            loginIdTextField.layer.borderWidth = 1
            loginIdTextField.layer.cornerRadius = 5
            loginIdTextField.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    // textField 입력 여부 확인
    func textFieldDidEdit() {
        loginIdTextField.addTarget(self, action: #selector(checkTextFieldFilled), for: .editingChanged)
        loginPwdTextField.addTarget(self, action: #selector(checkTextFieldFilled), for: .editingChanged)
    }
    
    @objc func checkTextFieldFilled() {
        if (loginIdTextField.text != "") {
            if (loginPwdTextField.text != "") {
                // 로그인 버튼 활성화
                loginButton.tintColor = .tintColor
                loginButton.isUserInteractionEnabled = true
            } else {
                // 로그인 버튼 비활성화
                loginButton.tintColor = buttonColor
                loginButton.isUserInteractionEnabled = false
            }
        }
        else {
            clearIdButton.isHidden = true
        }
    }
    
    // X 버튼 isHidden 설정
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == loginIdTextField) {
            print("입력 시작")
            if (loginIdTextField.text!.count > 0) { // 포커스 받았을 떄 텍스트가 있다면 x 버튼 표시
                clearIdButton.isHidden = false
            }
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField == loginIdTextField) {
            clearIdButton.isHidden = false // 값이 바뀌더라도 계속 표시
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField == loginIdTextField) {
            print("입력 완료")
            clearIdButton.isHidden = true
        }
    }
    
    @IBAction func loginButtonDidTap(_ sender: Any) {
        print("로그인 버튼 클릭")
        //login()
        postLoginData() // 로그인 진행
    }
    
    @IBAction func clearIdButtonDidTap(_ sender: Any) {
        print("x버튼 클릭")
        loginIdTextField.text = "" // TextField 입력란 비우기
        clearIdButton.isHidden = true // x버튼 숨기기
    }
    
    @IBAction func pwdVisibleButtonDidTap(_ sender: Any) {
        //print("비밀번호 표시 버튼 클릭")
        setPwdVisibility()
    }
    
    @IBAction func signUpButtonDidTap(_ sender: Any) {
        print("가입하기 버튼 클릭")
        guard let signupVC = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "SignupVC1") as?
                SignupEmailViewController else { return }
        
        // 회원가입 화면 전환
        signupVC.modalPresentationStyle = .fullScreen
        signupVC.modalTransitionStyle = .crossDissolve
        present(signupVC, animated: true)
        //navigationController?.pushViewController(signupVC, animated: true)
    }
    
    func setPwdVisibility() {
        if (isVisible == false) {
            print("비밀번호 표시")
            pwdVisibleButton.setImage(UIImage(named: "Visible"), for: .normal)
            loginPwdTextField.isSecureTextEntry = false
            isVisible = true
        }
        else {
            print("비밀번호 숨김")
            pwdVisibleButton.setImage(UIImage(named: "Invisible"), for: .normal)
            loginPwdTextField.isSecureTextEntry = true
            isVisible = false
        }
    }
    func setInitialUI() {
        // 텍스트필드
        loginIdTextField.attributedPlaceholder = NSAttributedString(string: "전화번호, 사용자 이름 또는 이메일", attributes: [.foregroundColor: UIColor.darkGray])
        loginPwdTextField.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [.foregroundColor: UIColor.darkGray])
        
        /* 초기 실행시 비활성화*/
        // 로그인 버튼
        loginButton.isUserInteractionEnabled = false
        loginButton.tintColor = buttonColor
        // x버튼
        clearIdButton.isHidden = true
        // 로그인 오류 메시지
        loginErrorLabel.isHidden = true
    }
    
    // MARK: - 2. 로그인
    func postLoginData() {
        guard let postId = loginIdTextField.text else { return }
        guard let postPwd = loginPwdTextField.text else { return }
        
        // http 요청 주소 지정
        let url = "https://kimmarie.shop/user/login"
        // http 요청 헤더 지정
        let header : HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        // http 요청 파라미터 지정
        let bodyData = [
            "userInfo": postId,
            "userPwd": postPwd
        ]
        
        print("Id: \(postId)")
        print("Pwd: \(postPwd)")
        
        // httpBody 에 parameters 추가
        AF.request(
            url, // 주소
            method: .post, // 전송 타입
            parameters: bodyData, // 전송 데이터
            encoding: JSONEncoding.default, // 인코딩 스타일
            headers: header // 헤더 지정
        )
        .validate(statusCode:  200..<300)
        .responseData { response in
            switch response.result {
            case .success(let res):
                do {
                    let data = try JSONDecoder().decode(SignupDataModel.self, from: res)
                    print(data.isSuccess)
                    print(data.code)
                    print(data.message)
                    print(data.result.userIdx)
                    print(data.result.jwt)
                    
                    
                    
                    if data.code == 1000 { // 회원가입 성공
                        print("로그인에 성공했습니다.")
                        
                        // 토큰 저장
                        let userToken = UserToken.shared
                        userToken.jwt = data.result.jwt
                        
                        // id, pwd 저장
                        UserDefaults.standard.set(postId, forKey: "signupId")
                        UserDefaults.standard.set(postPwd, forKey: "signupPwd")
                        
                        // 화면 전환
                        guard let mainVC = UIStoryboard(name: "Main", bundle: nil)
                            .instantiateViewController(withIdentifier: "TabBarController") as?
                                TabBarController else { return }
                        
                        mainVC.modalPresentationStyle = .fullScreen
                        mainVC.modalTransitionStyle = .crossDissolve
                        
                        self.present(mainVC, animated: true)
                    }
                }
                catch {
                    print("로그인 실패")
                }
            case .failure(let err):
                
                print(err)
            }
            
        }
    }
}
