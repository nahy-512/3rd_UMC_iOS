//
//  ProfileBottomSheet1ViewController.swift
//  Instagram
//
//  Created by 김나현 on 2022/11/06.
//

import UIKit

class ProfileBottomSheet1ViewController: UIViewController {
    
    // MARK: - Properties
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(UITableViewCell.self, forCellReuseIdentifier: "ProfileAddTableViewCell")
        view.delegate = self
        view.dataSource = self
        
        return view
    }()
    
    let bottomSheet1DataModel : [BottomSheet1DataModel] = [
        BottomSheet1DataModel(image : UIImage(named: "Reels"), title: "릴스"),
        BottomSheet1DataModel(image : UIImage(named: "PostGrid"), title: "게시물"),
        BottomSheet1DataModel(image : UIImage(named: "Story"), title: "스토리"),
        BottomSheet1DataModel(image : UIImage(named: "Highlight"), title: "스토리 하이라이트"),
        BottomSheet1DataModel(image : UIImage(named: "Live"), title: "라이브 방송"),
        BottomSheet1DataModel(image : UIImage(named: "Guide"), title: "가이드")
    ]
    
    //    var dataSource = [String]()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "만들기"
        
        //        for i in 0...100 {
        //            dataSource.append("\(i)")
        //        }
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40)
        ])
        
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

extension ProfileBottomSheet1ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bottomSheet1DataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileAddTableViewCell", for: indexPath) as? ProfileAddTableViewCell else {return UITableViewCell()}
        
        //        cell.cellButton.setImage(bottomSheet1DataModel[indexPath.row].image, for: .normal)
        cell.cellImageView.image = bottomSheet1DataModel[indexPath.row].image
        cell.cellButton.setTitle(bottomSheet1DataModel[indexPath.row].title, for: .normal)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(bottomSheet1DataModel[indexPath.row].title)
    }
}

struct BottomSheet1DataModel  {
    let image : UIImage?
    let title : String
}
