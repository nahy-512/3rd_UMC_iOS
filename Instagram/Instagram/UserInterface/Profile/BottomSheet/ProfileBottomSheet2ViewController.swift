//
//  ProfileBottomSheet2ViewController.swift
//  Instagram
//
//  Created by 김나현 on 2022/11/06.
//

import UIKit

class ProfileBottomSheet2ViewController: UIViewController {
    
    // MARK: - Properties
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(UITableViewCell.self, forCellReuseIdentifier: "ProfileAddTableViewCell")
        view.delegate = self
        view.dataSource = self
        
        
        
        return view
    }()
    
    let height = 600
    
    let bottomSheet2DataModel : [BottomSheet2DataModel] = [
        BottomSheet2DataModel(image : UIImage(named: "Settings"), title: "설정"),
        BottomSheet2DataModel(image : UIImage(named: "MyActivity"), title: "내 활동"),
        BottomSheet2DataModel(image : UIImage(named: "Storage"), title: "보관"),
        BottomSheet2DataModel(image : UIImage(named: "QRCode"), title: "QR 코드"),
        BottomSheet2DataModel(image : UIImage(named: "Saving"), title: "저장됨"),
        BottomSheet2DataModel(image : UIImage(named: "DigitalAsset"), title: "디지털 자산"),
        BottomSheet2DataModel(image : UIImage(named: "CloseFriend"), title: "친한 친구"),
        BottomSheet2DataModel(image : UIImage(named: "Star"), title: "즐겨찾기"),
        BottomSheet2DataModel(image : UIImage(named: "CoronaInfo"), title: "코로나19 정보 센터"),
    ]
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        //        title = "만들기"
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
        ])
        
        let safeAreaHeight : CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding : CGFloat = view.safeAreaInsets.bottom
        
//        self.bottomSheetViewTopConstraint.constant = ((safeAreaHeight + bottomPadding) - height)
        
        setupSheet()
        //        addNavigationBarButtonItem()
        setupNib()
        
    }
    
    // MARK: - Functions
    func setupNib() {
        let nibName = UINib(nibName: ProfileAddTableViewCell.identifier, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: ProfileAddTableViewCell.identifier)
    }
    
    private func setupSheet() {
        /// 밑으로 내려도 dismiss되지 않는 옵션 값
        isModalInPresentation = false // true
        
        if let sheet = sheetPresentationController {
            /// 드래그를 멈추면 그 위치에 멈추는 지점: default는 large()
            sheet.detents = [.medium()]
            /// 초기화 드래그 위치
            sheet.selectedDetentIdentifier = .medium
            /// sheet아래에 위치하는 ViewController를 흐려지지 않게 하는 경계값 (medium 이상부터 흐려지도록 설정)
            sheet.largestUndimmedDetentIdentifier = .medium
            /// sheet로 present된 viewController내부를 scroll하면 sheet가 움직이지 않고 내부 컨텐츠를 스크롤되도록 설정
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            /// grabber바 보이도록 설정
            sheet.prefersGrabberVisible = true
            /// corner 값 설정
            sheet.preferredCornerRadius = 32.0
            /// 높이 설정
            sheet.prefersEdgeAttachedInCompactHeight = true
            self.preferredContentSize.height = 600
        }
    }
    
    private func addNavigationBarButtonItem() {
        let medium = UIBarButtonItem(title: "medium", primaryAction: .init(handler: { [weak self] _Arg in
            self?.sheetPresentationController?.animateChanges {
                self?.sheetPresentationController?.selectedDetentIdentifier = .medium
            }
        }))
        navigationItem.leftBarButtonItem = medium
        
        let large = UIBarButtonItem(title: "large", primaryAction: .init(handler: { [weak self] _Arg in
            self?.sheetPresentationController?.animateChanges {
                self?.sheetPresentationController?.selectedDetentIdentifier = .large
            }
        }))
        navigationItem.rightBarButtonItem = large
    }
}

extension ProfileBottomSheet2ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bottomSheet2DataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileAddTableViewCell", for: indexPath) as? ProfileAddTableViewCell else {return UITableViewCell()}
        
//        cell.cellButton.setImage(bottomSheet2DataModel[indexPath.row].image, for: .normal)
        cell.cellImageView.image = bottomSheet2DataModel[indexPath.row].image
        cell.cellButton.setTitle(bottomSheet2DataModel[indexPath.row].title, for: .normal)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(bottomSheet2DataModel[indexPath.row].title)
    }
}

struct BottomSheet2DataModel  {
    let image : UIImage?
    let title : String
}
