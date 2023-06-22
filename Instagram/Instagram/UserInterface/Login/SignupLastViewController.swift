//
//  SignupLastViewController.swift
//  Instagram
//
//  Created by 김나현 on 2022/11/27.
//

import UIKit
import Alamofire

class SignupLastViewController: UIViewController { // #6
    
    // MARK: - Properties
    static let identifier = "SignupVC5"
    
    @IBOutlet weak var signupCheckMsgLabel: UILabel!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 이전 화면의 사용자 이름
        guard let saveId = UserDefaults.standard.string(forKey: "signupId") else { return }
        // 가입 확인 메시지
        signupCheckMsgLabel.text = "\(saveId)님으로 가입하시겠어요?"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    
    // MARK: - Functions
    
    func printUserInfo() { // 사용자 가입 정보 출력
        guard let saveEmail = UserDefaults.standard.string(forKey: "signupEmail") else { return }
        guard let saveName = UserDefaults.standard.string(forKey: "signupName") else { return }
        guard let savePwd = UserDefaults.standard.string(forKey: "signupPwd") else { return }
        guard let saveId = UserDefaults.standard.string(forKey: "signupId") else { return }
        
        // 마이페이지 정보 변경
        UserDefaults.standard.set(saveId, forKey: "myId")
        UserDefaults.standard.set(saveName, forKey: "myName")
        
        // 가입 정보 출력
        print("\(saveEmail), \(saveName), \(savePwd), \(saveId)")
        
    }
    @IBAction func signupButtonDidTap(_ sender: Any) { // 가입이 끝나면 로그인 화면으로
        print("가입하기 버튼 클릭")
        printUserInfo() // 유저 정보 출력
        
        postSignupData() // 서버 통신 -> 회원 가입
    }
    
    @IBAction func loginBtnDidTap(_ sender: Any) {
        // 회원 가입 취소 (데이터 삭제)
        UserDefaults.standard.set(nil, forKey: "signupEmail")
        UserDefaults.standard.set(nil, forKey: "signupName")
        UserDefaults.standard.set(nil, forKey: "signupPwd")
        UserDefaults.standard.set(nil, forKey: "signupId")
        
        guard let loginVC = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: LoginViewController.identifier) as?
                LoginViewController else { return }
        // 화면 전환
        loginVC.modalPresentationStyle = .fullScreen
        loginVC.modalTransitionStyle = .crossDissolve
        present(loginVC, animated: true)
        
        //self.navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - 1. 회원가입
    func postSignupData() {
        // http 요청 주소 지정
        let url = "https://kimmarie.shop/user/join"
        // http 요청 헤더 지정
        let header : HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        // http 요청 파라미터 지정
        let bodyData : Parameters = [
            "userName": UserDefaults.standard.string(forKey: "signupName"),
            "userId": UserDefaults.standard.string(forKey: "signupId"),
            "userEmail": UserDefaults.standard.string(forKey: "signupEmail"),
            "userPwd": UserDefaults.standard.string(forKey: "signupPwd")
        ]
        
//        // http 요청 수행 실시
//        print("")
//        print("====================================")
//        print("[\(self.postSignupData()) >> postSignupData() :: Post 방식 http 요청 실시]")
//        print("-------------------------------")
//        print("주 소 :: ", url)
//        print("-------------------------------")
//        print("데이터 :: ", params.description)
//        print("====================================")
//        print("")
        
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
                        print("회원가입에 성공했습니다.")
                        guard let loginVC = UIStoryboard(name: "Main", bundle: nil)
                            .instantiateViewController(withIdentifier: LoginViewController.identifier) as?
                                LoginViewController else { return }
                        // 화면 전환
                        loginVC.modalPresentationStyle = .fullScreen
                        loginVC.modalTransitionStyle = .crossDissolve
                        self.present(loginVC, animated: true)
                    }
                }
                catch (let err) {
                    print("회원가입 실패")
                }
                do {
                    let error = try JSONDecoder().decode(SignupDataModel.self, from: res)
                    print(error.isSuccess)
                    print(error.code)
                    print(error.message)
                } catch {
                    
                }
                break
            case .failure(let err):
                
                break
            }
            
        }
    }
}
