//
//  ViewController.swift
//  week4_mission
//
//  Created by 김나현 on 2022/10/14.
//
import Lottie
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    // MARK: - Properties
    let maxHeight: CGFloat = 140.0 //headerView의 최대 높이값
    let minHeight: CGFloat = 40.0 //headerVIew의 최소 높이값
    
    let refreshControl = UIRefreshControl()
    
    lazy var lottieView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "refreshLottie")
        animationView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        let centerX = UIScreen.main.bounds.width / 2
        animationView.center = CGPoint(x: centerX - 5, y: 40)
        animationView.contentMode = .scaleAspectFit
        animationView.stop()
        animationView.isHidden = true
        return animationView
    }()
    
    @IBOutlet weak var memoTableView: UITableView!{
        didSet {
            memoTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    @IBOutlet weak var memoCountLabel: UILabel!
    @IBOutlet weak var iCloudLabel: UILabel!
    
    /* Header */
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lowerHeaderView: UIView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint! { // headerView 높이 조절
        didSet {
            heightConstraint.constant = maxHeight
        }
    }
    
    // MARK: - Life Cyclee
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupTableView()
        initRefreshControl()
    }
    
    var memoDataModel: [MemoDataModel] = [ // PutDummyDatas
        MemoDataModel( // 0
            title: "Counting Star",
            date: "오전 4:16",
            content: "밤하늘의 퍼얼~",
            category: "메모",
            momoImage: nil
                     ),
        MemoDataModel( // 1
            title: "UMC 3기 iOS",
            date: "월요일",
            content: "오늘은 delegate와 TableView를 배웠다.",
            category: "공부",
            momoImage: nil
                     ),
        MemoDataModel( // 2
            title: "내 시험 공부🥲",
            date: "2022. 10. 9.",
            content: "시험 공부 언제 하냐...ㅠ",
            category: "체크리스트",
            momoImage: nil
                     ),
        MemoDataModel( // 3
            title: "시험 일정",
            date: "2022. 10. 7.",
            content: "[응용프로그래밍] 비전타워 103호 - 개념 빈칸, 결과 출력, 코드 구현, 객관식",
            category: "공부",
            momoImage: nil
                     ),
        MemoDataModel( // 4
            title: "대충 살자 . 기니피그처럼 .",
            date: "2022. 10. 1.",
            content: "대충 메모 내용이라는 뜻",
            category: "메모",
            momoImage: nil
                     ),
        MemoDataModel( // 5
            title: "솥뚜껑삼겹살",
            date: "2022. 10. 1.",
            content: "...또 먹으러 가고싶다",
            category: "메모",
            momoImage: nil
                     ),
        MemoDataModel( // 6
            title: "iOS 너무 어려움",
            date: "2022. 9. 28.",
            content: "But 혼자서도 잘해요(희망사항)",
            category: "메모",
            momoImage: nil
                     ),
        MemoDataModel( // 7
            title: "긔찮긔찮",
            date: "2022. 8. 19.",
            content: "더미 집어넣기도 귀찮다. 하지만 시험공부보다는 나은듯",
            category: "메모",
            momoImage: nil
                     ),
        MemoDataModel( // 8
            title: "내용이 없으면 '추가 텍스트 없음'을 띄워준다 와 !",
            date: "2022. 8. 14.",
            content: nil,
            category: "메모",
            momoImage: nil
                     ),
        MemoDataModel( // 9
            title: "내 생일",
            date: "2022. 1. 25",
            content: "내 생일 5의 세제곱 0125",
            category: "중요",
            momoImage: nil
                     ),
        MemoDataModel( // 10
            title: "나는 아무 생각이 없다.",
            date: "2021. 12. 25",
            content: "고로 존재하기 떄문이다.",
            category: "메모",
            momoImage: nil
                     ),
        MemoDataModel( // 11
            title: "스크롤 너무 힘들다",
            date: "2021. 12. 21",
            content: "해결방법을 못 찾겠어",
            category: "메모",
            momoImage: nil
                     ),
    ]
    
    
    // MARK: - Functions
    
    func setupTableView() {
        memoTableView.delegate = self
        memoTableView.dataSource = self
//        memoTableView.bounces = false
        
        // TableView에 Cell 등록
        let nibName = UINib(nibName: "TableViewCell", bundle: nil)
        memoTableView.register(nibName, forCellReuseIdentifier: "MemoTableViewCell")
    }
    
    func initRefreshControl(){
        refreshControl.addSubview(lottieView)
        refreshControl.tintColor = .clear
        refreshControl.addTarget(
            self,
            action: #selector(refreshTableView(refreshControl:)),
            for: .valueChanged
        )
        
        memoTableView.refreshControl = refreshControl
    }
    
    @objc func refreshTableView(refreshControl: UIRefreshControl) {
        print("새로고침!!")
        
        lottieView.isHidden = false
        lottieView.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.lottieView.isHidden = true
            self.lottieView.stop()
            self.memoTableView.reloadData()
            refreshControl.endRefreshing()
        }
    }
    

    
    // TableView item 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        memoCountLabel.text = "\(memoDataModel.count)개의 메모"
        return memoDataModel.count
    }
    
    // TableView Cell의 Object
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
                                                        "MemoTableViewCell", for: indexPath) as?
                TableViewCell else { return UITableViewCell() }
        
        // 각각의 Cell에 데이터 넣어주기
        cell.memoTitleLabel.text = memoDataModel[indexPath.row].title
        cell.memoDateLabel.text = memoDataModel[indexPath.row].date
        tableView.layer.cornerRadius = 10
        //        cell.layer.cornerRadius = 10 //set corner radius here
        //        cell.layer.masksToBounds = true
        
        
        if let content = memoDataModel[indexPath.row].content { // nil이 아니라면
            cell.memoContentLabel.text = memoDataModel[indexPath.row].content
        } else { // nil이라면
            cell.memoContentLabel.text = "추가 텍스트 없음"
        }
        cell.memoCategoryLabel.text = memoDataModel[indexPath.row].category
        if let memoImage = memoDataModel[indexPath.row].momoImage { // nil이 아니라면
            cell.memoContentImage.image = memoDataModel[indexPath.row].momoImage
        } else { // nil이라면
            cell.memoContentImage.isHidden = true
        }
        
        //        if indexPath.row == 0 { // 0번 index에 특징주기
        //            cell.backgroundColor = .systemPink
        //            cell.memoTitleLabel.textColor = .white
        //            cell.memoDateLabel.textColor = .white
        //            cell.memoContentLabel.textColor = .white
        //            cell.memoCategoryLabel.textColor = .white
        //        } else {
        //            cell.backgroundColor = .white
        //            cell.memoTitleLabel.textColor = .black
        //            cell.memoDateLabel.textColor = .systemGray
        //            cell.memoContentLabel.textColor = .systemGray
        //            cell.memoCategoryLabel.textColor = .systemGray
        //        }
        
        return cell
    }

    
    // 스와이프
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 오른쪽에 만들기
        
        let delete = UIContextualAction(style: .normal, title: "delete") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            print("Delete 클릭 됨")
            self.memoDataModel.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            success(true)
            
        }
        delete.backgroundColor = .systemRed
        delete.image = UIImage (systemName: "trash.fill")
        
        
        let folder = UIContextualAction(style: .normal, title: "folder") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            print("Folder 클릭 됨")
            success(true)
        }
        folder.backgroundColor = .systemPurple
        folder.image = UIImage (systemName: "folder.fill")
        
        
        let share = UIContextualAction(style: .normal, title: "share") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            print("Share 클릭 됨")
            success(true)
        }
        share.backgroundColor = .systemBlue
        share.image = UIImage (systemName: "person.crop.circle.badge.plus")
        
        //actions배열 인덱스 0이 왼쪽에 붙어서 나옴
        return UISwipeActionsConfiguration(actions:[delete, folder, share])
    }
}

// 들어갈 데이터 모델 정의
struct MemoDataModel {
    let title: String
    let date: String
    let content: String?
    let category: String
    let momoImage: UIImage?
}
