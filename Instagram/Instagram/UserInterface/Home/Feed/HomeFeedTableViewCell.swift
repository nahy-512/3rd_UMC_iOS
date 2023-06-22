//
//  HomeFeedTableViewCell.swift
//  Instagram
//
//  Created by 김나현 on 2022/11/05.
//

import UIKit
import Alamofire
import Kingfisher

class HomeFeedTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Properties
    static let cellId = "HomeFeedTableViewCell"
    static let className = "HomeFeedTableViewCell"
    
    @IBOutlet weak var homeFeedCollectionView: UICollectionView!
    
    var isHearted = false
    
    //var homeFeedDataModel = HomeFeedData.shared.homeFeedDataModel
//    var homeFeedDataModel : [HomeFeedDataModel] = [
//            HomeFeedDataModel(
//                profileImg : "profile", userName : "3rd_UMC_iOS", postImg : "study", postContent : "10月, 당신의 스터디는?", heartNum : 321, commentNum : 52, time : "어제", isLiked : false
//            ),
//            HomeFeedDataModel(
//                profileImg : "cocohaha", userName : "coco._.haha", postImg : "namo", postContent : "우리 나모 캐릭터🍊", heartNum : 999, commentNum : 125, time : "월요일", isLiked: false
//            ),
//            HomeFeedDataModel(
//                profileImg : "autumnCocoa", userName : "sundae_loverS2", postImg : "sundae", postContent : "아 기 그 잡 채", heartNum : 1234567, commentNum : 5, time : "10월 4일", isLiked : false
//            )
//    ]
    
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print("awakeFromNib()")
        
        getFeedData() // 서버 통신 -> 피드 받아오기
        
        setFeedCollectionView()
        inputItems()
        
        
        // UserDefaults 값 초기화
        //UserDefaults.standard.set(nil, forKey: "feedData")
        
        // UserDefaults 저장값 확인
        //        let feedData = UserDefaults.standard.value(forKey: "feedData") as? Data
        //
        //        if (feedData != nil) { // 값이 있다면 받아와서 dataModel에 넣어주기
        //            self.homeFeedDataModel = try! PropertyListDecoder().decode([HomeFeedDataModel].self, from: feedData!)
        //            print("UserDefault - Decoding")
        //        } else { // 없다면(nil) userDefaults에 저장
        //            UserDefaults.standard.set(try? PropertyListEncoder().encode(self.homeFeedDataModel), forKey: "feedData")
        //            print("UserDefault - Encoding")
        //        }
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    // MARK: - Functions
    func setFeedCollectionView() {
        homeFeedCollectionView.delegate = self
        homeFeedCollectionView.dataSource = self
        
        let feedNib = UINib(nibName: "HomeFeedCollectionViewCell", bundle: nil)
        homeFeedCollectionView.register(feedNib, forCellWithReuseIdentifier: "HomeFeedCollectionViewCell")
    }
    
    private func inputItems() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 1 // 아이템 사이의 공간 값
        let width = UIScreen.main.bounds.width
        let height = width + 200
        
        
        layout.itemSize = CGSize(width: width, height: height) //아이템 사이즈 초기화
        layout.scrollDirection = .vertical // 아이템 스크롤 방향
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing) //아이템 상하좌우 사이값 초기화
        layout.minimumLineSpacing = spacing //아이템 라인 사이값 초기화
        layout.minimumInteritemSpacing = spacing //아이템 섹션 사이값 초기화
        
        homeFeedCollectionView.collectionViewLayout = layout //CollctionView의 Layout 적용
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // 저장된 데이터 가져오기
        let homeFeedDataModel = HomeFeedData.shared.homeFeedDataModel
        
        print(homeFeedDataModel.count)
        return homeFeedDataModel.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = homeFeedCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeFeedCollectionViewCell", for: indexPath) as?
                HomeFeedCollectionViewCell else { return UICollectionViewCell() }
        
        // 저장된 데이터 가져오기
        let homeFeedDataModel = HomeFeedData.shared.homeFeedDataModel
        
        let rowIndex = homeFeedDataModel[indexPath.row]
        
        /** 스토리 셀 데이터 넣기 */
        // 프로필 이미지
        if rowIndex.userProfileImg != "" { // nil이 아니면
            let imageUrl = URL(string: rowIndex.userProfileImg!)
            cell.profileImageView.kf.setImage(with: imageUrl)
        } else { // nil이면 default 이미지
            cell.profileImageView.image = UIImage(named: "profile")
        }
        // 유저 id
        cell.userNameLabel.text = rowIndex.userID
        cell.userName2Label.text = rowIndex.userID
        // 게시물 사진
        let imageUrl = URL(string: rowIndex.imgList[0].postImgUrl)
        cell.postImageView.kf.setImage(with: imageUrl)
        // 게시물 글
        cell.postContentLabel.text = rowIndex.postContent
        // 업로드 시간
        cell.timeLabel.text = rowIndex.uploadTime
        
        
        // 좋아요, 댓글수 출력 포멧
        let numberFormatter = NumberFormatter() // NumberFormatter 객체 생성
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(for: rowIndex.commentNum)!
        
        let commentPrint = "댓글 \(rowIndex.commentNum)개 모두 보기"
        
        cell.heartNum = rowIndex.commentNum
        cell.heartNumLabel.text = "좋아요 \(result)개"
        cell.commentNumLabel.text = commentPrint
        //cell.cellIndex = indexPath.row
        //cell.isHearted = homeFeedDataModel[indexPath.row].isLiked
        
        return cell
    }
    
    // MARK: - 4. 홈 화면 게시물
    func getFeedData() {
        
        // 저장된 jwt 가져오기
        let jwt = UserToken.shared.jwt!
        print("[HomeFeedTableViewCell]")
        print("jwt: \(jwt)")
        
        // http 요청 주소 지정
        let url = "https://kimmarie.shop/post/home"
        
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
        .validate(statusCode: 200..<300)
        .responseData { response in
            switch response.result {
            case .success(let res):
                do {
                    let data = try JSONDecoder().decode(HomeFeedDataModel.self, from: res)
                    
                    print(data.isSuccess, data.code, data.message)
                    
                    if data.code == 1000 { // 성공 코드
                        print("게시물 불러오기를 성공했습니다.")
                        let feedData = HomeFeedData.shared
                        
                        // 값 넣어주기
                        feedData.homeFeedDataModel = data.result
                        self.homeFeedCollectionView.reloadData()
                        // let getData = data.result
                        // self.homeFeedDataModel = getData
//                        print("test = \(self.homeFeedDataModel[0].imgList[0].postImgUrl)")
                        //print("homeFeedDataModel = \(self.homeFeedDataModel)")
                    }
                }
                catch {
                    print("게시물 불러오기 실패")
                }
            case .failure(let err):
                
                print(err)
            }
        }
    }
    
}

//extension HomeFeedTableViewCell : NotifyHeartTapDelegate {
//
//    func onClickHeart(index: Int, isHearted: Bool) { // Cell의 하트가 클릭됐을 때 데이터 저장값 변경해주기
//        //print("onClickHeart")
//        self.homeFeedDataModel[index].isLiked = isHearted
//        if (isHearted) { // 좋아요 수 데이터 업데이트
//            homeFeedDataModel[index].heartNum += 1
//        }
//        else {
//            homeFeedDataModel[index].heartNum -= 1
//        }
//        //print(homeFeedDataModel[index].heartNum)
//        UserDefaults.standard.set(try? PropertyListEncoder().encode(homeFeedDataModel), forKey: "feedData") // 변경사항을 UserDefaults에 저장
//    }
//}

//struct HomeFeedDataModel : Codable {
//    let profileImg : String
//    let userName : String
//    let postImg : String
//    let postContent : String?
//    var heartNum : Int
//    var commentNum : Int
//    let time : String
//    var isLiked : Bool
//}
