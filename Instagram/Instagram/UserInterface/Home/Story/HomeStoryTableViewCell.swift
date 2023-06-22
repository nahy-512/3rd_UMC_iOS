//
//  HomeStoryTableViewCell.swift
//  Instagram
//
//  Created by 김나현 on 2022/11/04.
//

import UIKit


protocol StoryDelegate {
    func presentStoryVC(_ index: Int, userName: String)
}

class HomeStoryTableViewCell: UITableViewCell  {
    
    
    // MARK: - Properties
    static let cellId = "HomeStoryTableViewCell"
    static let className = "HomeStoryTableViewCell"
    
    var delegate: StoryDelegate? // delegate 변수 선언
    
    @IBOutlet weak var homeStoryCollectionView: UICollectionView!
    
    
    var homeStoryDataModel : [HomeStoryDataModel] = [
        HomeStoryDataModel(profileImage: "autumnCocoa", userName: "내 스토리", isReaded: false),
        HomeStoryDataModel(profileImage: "yeonHyun", userName: "yeonHyun", isReaded: false),
        HomeStoryDataModel(profileImage: "gogh", userName: "gogh", isReaded: false),
        HomeStoryDataModel(profileImage: "tori", userName: "seori", isReaded: false),
        //HomeStoryDataModel(profileImage: UIImage(named: "namo"), userName: "namo", isReaded: false),
        //HomeStoryDataModel(profileImage: UIImage(named: "sundae"), userName: "sundae", isReaded: false),
        HomeStoryDataModel(profileImage: "cocohaha", userName: "cocohaha", isReaded: false),
        HomeStoryDataModel(profileImage: "bori", userName: "bori", isReaded: false)
    ]
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 스토리 데이터 초기화
        //UserDefaults.standard.set(nil, forKey: "storyData")
        
        setStoryCollecionView()
        inputItems()
        
        
        let storyData = UserDefaults.standard.value(forKey: "storyData") as? Data
        
        
        if (storyData != nil) {
            self.homeStoryDataModel = try! PropertyListDecoder().decode([HomeStoryDataModel].self, from: storyData!)
        } else {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self.homeStoryDataModel), forKey: "storyData")
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    // MARK: - Functions
    func setStoryCollecionView() {
        homeStoryCollectionView.delegate = self
        homeStoryCollectionView.dataSource = self
        
        // Nib 등록
        let storyNib = UINib(nibName: HomeStoryCollectionViewCell.className, bundle: nil)
        homeStoryCollectionView.register(storyNib, forCellWithReuseIdentifier: HomeStoryCollectionViewCell.cellId)
    }
    
    private func inputItems() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 15 // 아이템 사이의 공간 값
        let width = 70
        let height = 100
        
        layout.itemSize = CGSize(width: width, height: height) //아이템 사이즈 초기화
        layout.scrollDirection = .horizontal // 아이템 스크롤 방향
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing) //아이템 상하좌우 사이값 초기화
        layout.minimumLineSpacing = spacing //아이템 라인 사이값 초기화
        layout.minimumInteritemSpacing = spacing //아이템 섹션 사이값 초기화
        
        homeStoryCollectionView.collectionViewLayout = layout //CollctionView의 Layout 적용
    }
}

extension HomeStoryTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return homeStoryDataModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = homeStoryCollectionView.dequeueReusableCell(withReuseIdentifier: HomeStoryCollectionViewCell.cellId, for: indexPath) as? HomeStoryCollectionViewCell else { return UICollectionViewCell() }
        
        // 스토리 셀 데이터 넣기
        if let profileImage = homeStoryDataModel[indexPath.row].profileImage {
            cell.storyProfileImageView.image = UIImage(named: profileImage)
        }
        else { // nil이라면 기본 이미지 반환
            cell.storyProfileImageView.image = UIImage(named: "profile")
        }
        cell.storyProfileNameLabel.text = homeStoryDataModel[indexPath.row].userName
        
        // 내스토리
        if indexPath.row == 0 {
            cell.storyPlusImageView.isHidden = false
            cell.storyProfileBackgroundView.layer.borderColor = UIColor.clear.cgColor
        }
        
        // 읽은 스토리 처리
        if (homeStoryDataModel[indexPath.row].isReaded == true) {
            cell.storyProfileBackgroundView.layer.borderColor = UIColor.systemGray4.cgColor
        }
        
        ///print(homeStoryDataModel)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.item)번째 아이템 클릭")
        
        
        if (indexPath.item != 0) { // 내 스토리가 아니라면 화면 넘기기
            if let delegate = delegate {
                
                let sendName = homeStoryDataModel[indexPath.row].userName
                delegate.presentStoryVC(indexPath.item, userName: sendName)
                print("sendName : \(sendName)")
            }
            
            // 클릭하면 스토리 읽음 처리
            if (homeStoryDataModel[indexPath.item].isReaded == false) {
                
                homeStoryDataModel[indexPath.item].isReaded = true
                
                let tempData = homeStoryDataModel[indexPath.item]
                homeStoryDataModel.remove(at: indexPath.item)
                homeStoryDataModel.append(tempData)
                UserDefaults.standard.set(try? PropertyListEncoder().encode(homeStoryDataModel), forKey: "storyData")
                
                
            }
        }
        
        collectionView.reloadData()
        
    }
}

struct HomeStoryDataModel : Codable {
    let profileImage : String?
    let userName : String
    var isReaded : Bool
}


/*
// userDefaults
enum userDefaultsKeys : String {
    case profileImage
    case StoryInfo
    case HomeStoryDataModel
}

struct StoryInfo: Codable {
    var profileImage : String
    var userName : String
    var isReaded : Bool
}

extension AppDelegate{
    //
    func setStoryInfo(){
            var user = HomeStoryDataModel(profileImage: "namo", userName: "my_namo", isReaded: false)
            var propertyListEncoder = try? PropertyListEncoder().encode(user)
            var userCoreData = UserDefaults.standard
            userCoreData.set(propertyListEncoder, forKey: userDefaultsKeys.StoryInfo.rawValue)
            userCoreData.synchronize()
    }
}
*/
