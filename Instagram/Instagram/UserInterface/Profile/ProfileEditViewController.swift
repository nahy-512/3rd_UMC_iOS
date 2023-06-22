//
//  ProfileEditViewController.swift
//  Instagram
//
//  Created by 김나현 on 2022/10/03.
//

import UIKit
import Alamofire

protocol SendDataDelegate: AnyObject {
    func sendData(userID: String, userName: String, siteLink: String, introduce: String)
}


class ProfileEditViewController : UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: SendDataDelegate?
    
    var preId = "umc_3rd_iOS"
    var preName = "가천대학교 UMC 3기 iOS"
    var preIntroduce : String?
    var preSiteLink : String?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var editNameTF: UITextField!
    @IBOutlet weak var editIdTF: UITextField!
    @IBOutlet weak var editSiteTF: UITextField!
    @IBOutlet weak var editIntroductionTF: UITextField!
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 이전 화면에서 넘겨받은 텍스트
        editIdTF.text = preId
        editNameTF.text = preName
        editSiteTF.text = preSiteLink
        editIntroductionTF.text = preIntroduce
        
        addTextUnderLine() // 텍스트필드 밑줄 추가
    }
    
    
    // MARK: - Functions
    
    @IBAction func editCancalBtn(_ sender: Any) { // 수정 취소
        print("프로필 수정 취소")
        self.presentingViewController?.dismiss(animated: true)
    }
    
    
    @IBAction func editSaveBtn(_ sender: Any) { // 수정 완료 저장
        print("프로필 수정 완료")
        
        // 텍스트값 가져오기
        guard let editID = editIdTF.text else { return }
        guard let editName = editNameTF.text else { return }
        guard let editSite = editSiteTF.text else { return }
        guard let editIntroduce = editIntroductionTF.text else { return }
        
        // UserDefault 값 담기
        UserDefaults.standard.set(editID, forKey: "myId")
        UserDefaults.standard.set(editName, forKey: "myName")
        UserDefaults.standard.set(editSite, forKey: "mySite")
        UserDefaults.standard.set(editIntroduce, forKey: "myIntroduce")
        
        patchMyInfo(id: editID, name: editName, site: editSite, introduce: editIntroduce) // 서버 통신 -> 내정보 수정
        
        // 변경된 이름값 담기
        self.delegate?.sendData(userID: editID, userName: editName, siteLink : editSite, introduce: editIntroduce)
        
        // 이전 화면으로 이동
        self.presentingViewController?.dismiss(animated: true)
        
    }
    
    
    func addTextUnderLine() { // 텍스트필드 밑줄 추가
        let border1 = CALayer(); let border2 = CALayer(); let border3 = CALayer()
        
        // 1
        editNameTF.borderStyle = .none
        border1.frame = CGRect(x: 0, y: editNameTF.frame.size.height-1, width: editNameTF.frame.width, height: 1)
        border1.backgroundColor = UIColor.systemGray5.cgColor
        editNameTF.layer.addSublayer((border1))
        // 2
        editIdTF.borderStyle = .none
        border2.frame = CGRect(x: 0, y: editIdTF.frame.size.height-1, width: editIdTF.frame.width, height: 1)
        border2.backgroundColor = UIColor.systemGray5.cgColor
        editIdTF.layer.addSublayer((border2))
        // 3
        editSiteTF.borderStyle = .none
        border3.frame = CGRect(x: 0, y: editSiteTF.frame.size.height-1, width: editSiteTF.frame.width, height: 1)
        border3.backgroundColor = UIColor.systemGray5.cgColor
        editSiteTF.layer.addSublayer((border3))
        // 4
        editIntroductionTF.borderStyle = .none
    }
    
    // MARK: - 3. 유저 정보 수정
    func patchMyInfo(id : String, name : String, site : String, introduce : String) {
        
        // 저장된 jwt 가져오기
        guard let jwt = UserToken.shared.jwt else { return }
        print("[ProfileEditViewController]")
        print("jwt: \(jwt)")
        
        // http 요청 주소 지정
        let url = "https://kimmarie.shop/user/mod"
        
        // http 요청 헤더 지정
        let header : HTTPHeaders = [
            "Content-Type" : "application/json",
            "X-ACCESS-TOKEN" : jwt
        ]
        let bodyData : Parameters = [
            "userName": name,
            "userId" : id,
            "userIntro" : introduce,
            "userWebsite" : site
        ]
        print(name, id, introduce, site)
        
        // httpBody 에 parameters 추가
        AF.request(
            url, // 주소
            method: .patch, // 전송 타입
            parameters: bodyData, // 전송 데이터
            encoding: JSONEncoding.default, // 인코딩 스타일
            headers: header // 헤더 지정
        )
        .validate(statusCode: 200..<300)
        .responseData { response in
            switch response.result {
            case .success(let res):
                do {
                    let data = try JSONDecoder().decode(InfoDataModel.self, from: res)
                    print(data.isSuccess, data.code, data.message)
                    
                    
                    if data.code == 1000 { // 회원가입 성공
//                        print("정보 수정을 성공했습니다.")
                        print(data.result)
                        
                    }
                }
                catch {
                    print("정보 수정 실패")
                }
            case .failure(let err):
                print(err)
            }
        }
    }
}
