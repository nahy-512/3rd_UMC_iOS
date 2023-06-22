//
//  ProfileViewController.swift
//  Instagram
//
//  Created by 서은수 on 2022/09/19.
//

import UIKit
import Alamofire

class ProfileViewController: UIViewController, SendDataDelegate {
    
    // MARK: - Properties
    
    var userId : String? // "umc_3rd_iOS"
    var userName : String? // "가천대학교 UMC 3기 iOS"
    var userSite : String?
    var userIntroduce: String?
    
    //    private var data = PostData()
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userIntroduceLabel: UILabel!
    @IBOutlet weak var userSiteLinkLabel: UILabel!
    @IBOutlet weak var storyPlus: UIImageView!
    @IBOutlet weak var profileImageButton: UIButton!
    
    @IBOutlet weak var postNumLabel: UILabel!
    @IBOutlet weak var followerNumLabel: UILabel!
    @IBOutlet weak var followingNumLabel: UILabel!
    
    
    @IBOutlet weak var redButton: UIButton!
    
    @IBOutlet weak var profileEditButton: UIButton!
    
    @IBOutlet weak var profilePostCollectionView: UICollectionView!
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redButton.tintColor = .systemRed
        profileEditButton.titleLabel?.textColor = UIColor.black
        
        
        self.profilePostCollectionView.delegate = self
        self.profilePostCollectionView.dataSource = self
        
        registerNib() // Nib 등록
        
        inputItems()
        setUI()
        getMyInfo() // 서버 통신 -> 내 정보 불러오기
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // 이름 변경
        if let iD = userId {
            userIdLabel.text = iD
        }
        if let name = userName {
            userNameLabel.text = name
        }
        if let site = userSite {
            userSiteLinkLabel.text = site
        }
        if let introduce = userIntroduce {
            userIntroduceLabel.text = introduce
        }
        
        
        
        // profileInfoSetting() // 저장된 user 이름 가져오기
    }
    
    let postDataModel: [PostDataModel] = [
        PostDataModel(profilePostImage: UIImage(named: "namo")),
        PostDataModel( profilePostImage: UIImage(named: "sundae")),
        PostDataModel(profilePostImage: UIImage(named: "picniq")),
        PostDataModel(profilePostImage: UIImage(named: "study")),
        //        PostDataModel(profilePostImage: UIImage(named: "namo")),
        //        PostDataModel( profilePostImage: UIImage(named: "sundae")),
        //        PostDataModel(profilePostImage: UIImage(named: "picniq")),
    ]
    
    // MARK: - Functions
    
    func setUI() {
        storyPlus.layer.cornerRadius = 15
        storyPlus.contentMode = .scaleAspectFill
        storyPlus.clipsToBounds = true
        storyPlus.layer.borderWidth = 2
        storyPlus.layer.borderColor = UIColor.white.cgColor
    }
    
    func sendData(userID: String, userName: String, siteLink: String, introduce: String) {
        self.userIdLabel.text = userID
        self.userNameLabel.text = userName
        self.userSiteLinkLabel.text = siteLink
        self.userIntroduceLabel.text = introduce

    }
    
    private func registerNib() { // Nib 등록
        let nibName = UINib(nibName: "ProfilePostCollectionViewCell", bundle: nil)
        profilePostCollectionView.register(nibName, forCellWithReuseIdentifier: "ProfilePostCollectionViewCell")
    }
    
    private func inputItems() { // 한줄 당 3개, 화면 사이즈에 맞게 출력
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 1 // 아이템 사이의 공간 값
        let width = (UIScreen.main.bounds.width - (spacing * 4)) / 3
        //아이템의 가로값: (스크린의 가로길이 - 아이템 사이공간 * (가로에 배치할 아이템 개수 + 1)) / 가로에 배치 할 아이템 개수
        let height = width // 정방형 (1:1)
        
        layout.itemSize = CGSize(width: width, height: height) //아이템 사이즈 초기화
        layout.scrollDirection = .vertical // 아이템 스크롤 방향
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing) //아이템 상하좌우 사이값 초기화
        layout.minimumLineSpacing = spacing //아이템 라인 사이값 초기화
        layout.minimumInteritemSpacing = spacing //아이템 섹션 사이값 초기화
        
        profilePostCollectionView.collectionViewLayout = layout //CollctionView의 Layout 적용
    }
    
    @IBAction func profileEditBtn(_ sender: Any) { // 프로필 편집 버튼
        
        print("프로필 편집 버튼 클릭")
        
        // 프로필 수정 화면으로 넘길 텍스트
        guard let passId = userIdLabel.text else { return }
        guard let passName = userNameLabel.text else { return }
        guard let passIntro = userIntroduceLabel.text else { return }
        guard let passSiteLink = userSiteLinkLabel.text else { return }
        
        // 화면 전환
        guard let secondViewController = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileEditVC") as? ProfileEditViewController else { return }
        
        // 화면 전환될 때 텍스트 넘기기
        secondViewController.preId = passId
        secondViewController.preName = passName
        secondViewController.preIntroduce = passIntro
        secondViewController.preSiteLink = passSiteLink
        
        // 전환된 화면이 보여지는 방법 설정 (fullScreen)
        secondViewController.modalPresentationStyle = .fullScreen
        secondViewController.delegate = self
        present(secondViewController, animated: true)
    }
    
    @IBAction func addPostBtn(_ sender: Any) { // 바텀시트 1
        //        let bottomSheet1VC = ProfileAddBottomSheetViewController()
        
        //        let bottomSheet1VC = ProfileAddBottomSheetViewController(contentViewController: UITableViewController())
        //        bottomSheet1VC.modalPresentationStyle = .overFullScreen
        //        self.present(bottomSheet1VC, animated: false, completion: nil)
        
        showMyBottomSheet1()
        
        print("바텀시트 1 버튼 클릭")
        
    }
    
    @IBAction func hamburgerBtn(_ sender: Any) { // 바텀시트 2
        showMyBottomSheet2()
        
        print("바텀시트 2 버튼 클릭")
    }
    
    @IBAction func profileBtn(_ sender: Any) { // 프로필 이미지 버튼
        print("프로필 이미지 버튼 클릭")
    }
    
    func showMyBottomSheet1() {
        let navigationController = UINavigationController(rootViewController: ProfileBottomSheet1ViewController())
        present(navigationController, animated: true, completion: nil)
    }
    func showMyBottomSheet2() {
        let navigationController = UINavigationController(rootViewController: ProfileBottomSheet2ViewController())
        present(navigationController, animated: true, completion: nil)
    }
    
    func profileInfoSetting() { // 저장된 이름 가져오기
        let savedId = UserDefaults.standard.string(forKey: "myId")
        let savedName = UserDefaults.standard.string(forKey: "myName")
        let savedSite = UserDefaults.standard.string(forKey: "mySite")
        let savedIntroduce = UserDefaults.standard.string(forKey: "myIntroduce")
        
        if (savedId != nil) {
            userIdLabel.text = savedId
        }
        if (savedName != nil) {
            userNameLabel.text = savedName
        }
        if (savedSite != nil) {
            userSiteLinkLabel.text = savedSite
        }
        if (savedIntroduce != nil) {
            userIntroduceLabel.text = savedIntroduce
        }
    }
    
    // MARK: - 5. 마이페이지 유저 정보
    func getMyInfo() {
        
        // 저장된 jwt 가져오기
        guard let jwt = UserToken.shared.jwt else { return }
        print("[ProfileViewController]")
        print("jwt: \(jwt)")
        
        // http 요청 주소 지정
        let url = "https://kimmarie.shop/mypage/profile"
        
        // http 요청 헤더 지정
        let header : HTTPHeaders = [
            "Content-Type" : "application/json",
            "X-ACCESS-TOKEN" : jwt
        ]
       
        // httpBody에 parameters 추가
        AF.request(
            url, // 주소
            method: .get, // 전송 타입
            encoding: JSONEncoding.default, // 인코딩 스타일
            headers: header // 헤더 지정
        )
        .validate(statusCode:  200..<300)
        .responseData { response in
            switch response.result {
            case .success(let res):
                do {
                    let data = try JSONDecoder().decode(MyPageDataModel.self, from: res)
                    print(data.isSuccess, data.code, data.message, data.result.userIdx)
                    
                    
                    if data.code == 1000 { // 성공 코드
                        print("회원 정보 불러오기를 성공했습니다.")
                        let get = data.result
                        
                        // 값 넣어주기
                        self.userIdLabel.text = get.userID
                        self.userNameLabel.text = get.userName
                        if let userProfileImg = get.userProfileImg { // 프로필 이미지 값이 있으면
                            self.profileImageButton.setImage(UIImage(named: userProfileImg), for: .normal)
                        } else {
                            self.profileImageButton.setImage(UIImage(named: "profile"), for: .normal)
                        }
                        if let userIntro = get.userIntro { // 자기소개가 있으면
                            self.userIntroduceLabel.text = userIntro
                        } else {
                            self.userIntroduceLabel.text = ""
                        }
                        if let userWebsite = data.result.userWebsite { // 웹사이트 링크
                            self.userSiteLinkLabel.text = userWebsite
                        } else {
                            self.userSiteLinkLabel.text = ""
                        }
//                        self.userIntroduceLabel.text = get.userIntro
//                        self.userSiteLinkLabel.text = get.userWebsite
                        self.postNumLabel.text = String(get.postNum)
                        self.followerNumLabel.text = String(get.followerNum)
                        self.followingNumLabel.text = String(get.followingNum)
                    }
                }
                catch {
                    print("회원 정보 불러오기 실패")
                }
            case .failure(let err):
                
                print(err)
            }
        }
    }
}


extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postDataModel.count
        //        return data.imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = profilePostCollectionView.dequeueReusableCell(withReuseIdentifier: "ProfilePostCollectionViewCell", for: indexPath) as! ProfilePostCollectionViewCell
        //        cell.postImageView.image = data.imageArray[indexPath.row]
        cell.postImageView.contentMode = .scaleAspectFill
        cell.postImageView.clipsToBounds = true
        cell.postImageView.image = postDataModel[indexPath.row].profilePostImage
        return cell
    }
}

extension ProfileViewController: UISheetPresentationControllerDelegate {
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        
    }
}

struct PostDataModel {
    let profilePostImage: UIImage?
}
