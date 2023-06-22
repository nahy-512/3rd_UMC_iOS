//
//  LoginViewController.swift
//  week9
//
//  Created by 김나현 on 2022/11/26.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    var userName : String? = ""
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Functions
    
    @IBAction func loginButtonDidTap(_ sender: Any) {
        // 카카오톡 설치 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            // 카카오톡 로그인. api 호출 결과를 클로저로 전달
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error { // 예외 처리 (로그인 취소 등)
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    
                    //do something
                    _ = oauthToken
                    // 액세스토큰
                    let accessToken = oauthToken?.accessToken
                    
                    // 카카오 로그인으로 사용자 토큰을 발급받은 후 사용자 관리 API 호출
                    self.setUserInfo()
                }
            }
        }
    }
    
    func setUserInfo() {
        UserApi.shared.me() { [self](user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
                //do something
                _ = user
                let name = user?.kakaoAccount?.profile?.nickname
                userName = name
                userNameLabel.text = String(name!)
                print("userName:\(name)")
                
                if let url = user?.kakaoAccount?.profile?.profileImageUrl,
                   let data = try? Data(contentsOf: url) {
                    profileImageView.image = UIImage(data: data)
                }
            }
        }
        
        guard let secondVC = UIStoryboard(name:
                                            "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "mainVC") as?
                ViewController else { return }
        
        // 유저 이름 담기
        guard let resultUserName = userNameLabel.text else { return }
        print("넘어갈 userName: \(resultUserName)")
        secondVC.userName = resultUserName // 유저 이름 담음
        //secondVC.userNameLabel.text = userName! + "님"
        
        // 화면 전환
        //                    secondVC.modalPresentationStyle = .fullScreen
        //                    present(secondVC, animated: true)
    }
}
