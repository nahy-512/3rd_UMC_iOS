////
////  ProfileAddTableViewController.swift
////  Instagram
////
////  Created by 김나현 on 2022/11/06.
////
//
//import UIKit
//
//class ProfileAddTableViewController: UITableViewController {
//    
//    // MARK: - Properties
//    let bottomSheet1DataModel : [BottomSheet1DataModel] = [
//        BottomSheet1DataModel(image : UIImage(named: "Reels"), title: "릴스"),
//        BottomSheet1DataModel(image : UIImage(named: "PostGrid"), title: "게시물"),
//        BottomSheet1DataModel(image : UIImage(named: "Story"), title: "스토리"),
//        BottomSheet1DataModel(image : UIImage(named: "Highlight"), title: "스토리 하이라이트"),
//        BottomSheet1DataModel(image : UIImage(named: "Live"), title: "라이브 방송"),
//        BottomSheet1DataModel(image : UIImage(named: "Guide"), title: "가이드")
//    ]
//    
//    // MARK: - Life Cycles
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        tableView.delegate = self
//        tableView.dataSource = self
//        
//        setupNib()
//    }
//    
//    // MARK: - Functions
//    func setupNib() {
//        let nibName = UINib(nibName: ProfileAddTableViewCell.identifier, bundle: nil)
//        tableView.register(nibName, forCellReuseIdentifier: ProfileAddTableViewCell.identifier)
//    }
//    
//    // MARK: - Table view data source
//    override func numberOfSections(in tableView: UITableView) -> Int { // 섹션 개수
//        
//        return 1
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // 행 개수
//        return bottomSheet1DataModel.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileAddTableViewCell", for: indexPath) as? ProfileAddTableViewCell else {return UITableViewCell()}
//
//        cell.cellButton.imageView?.image = bottomSheet1DataModel[indexPath.row].image
//        cell.cellButton.titleLabel?.text = bottomSheet1DataModel[indexPath.row].title
//
//        return cell
//    }
//}
//
////struct BottomSheet1DataModel  {
////    let image : UIImage?
////    let title : String
////}
