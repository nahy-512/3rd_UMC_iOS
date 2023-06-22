//
//  HomeViewController.swift
//  Instagram
//
//  Created by 김나현 on 2022/10/18.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    // MARK: - Properties
    @IBOutlet weak var homeTableView: UITableView!
    
    let refreshControl = UIRefreshControl()

    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        initRefreshControl()
    }
    
    // MARK: - Functions
    func setupTableView() {
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        // 스토리 테이블뷰셀 Nib 등록
        homeTableView.register(UINib(nibName: HomeStoryTableViewCell.className, bundle: nil), forCellReuseIdentifier: HomeStoryTableViewCell.cellId)
        
        // 피드 테이블뷰셀 Nib 등록
        homeTableView.register(UINib(nibName: HomeFeedTableViewCell.className, bundle: nil), forCellReuseIdentifier: HomeFeedTableViewCell.cellId)
        
    }
    
//    func presentStoryVC(userName: String) {
//        guard let secondVC = self.storyboard?.instantiateViewController(withIdentifier: StoryViewController.identifier) as? StoryViewController else {return}
//        print("presentStoryVC 함수")
//        secondVC.modalPresentationStyle = .fullScreen
//        secondVC.userName = userName
//
//        self.present(secondVC, animated: true)
//    }
    
    
    func initRefreshControl() {
        homeTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc func handleRefreshControl() {
        
        print("새로고침 됨")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.refreshControl.endRefreshing()
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = homeTableView.dequeueReusableCell(withIdentifier: HomeStoryTableViewCell.cellId, for: indexPath) as? HomeStoryTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            return cell
        case 1:
            guard let cell = homeTableView.dequeueReusableCell(withIdentifier: HomeFeedTableViewCell.cellId, for: indexPath) as? HomeFeedTableViewCell else { return UITableViewCell() }
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return 100
        case 1:
            return (UIScreen.main.bounds.width + 200) * 3
        default:
            return 0
        }
    }
}

extension HomeViewController: StoryDelegate { // Cell 클릭 시 스토리VC로 화면 전환

    func presentStoryVC(_ index: Int, userName: String) {
        guard let storyVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: StoryViewController.identifier) as? StoryViewController else {
            return
        }
        
        storyVC.cellNum = "\(index)번째 셀"
        storyVC.userName = userName

        print(storyVC.cellNum)
        
        storyVC.modalPresentationStyle = .overFullScreen
        storyVC.modalTransitionStyle = .crossDissolve
        present(storyVC, animated: true, completion: nil)
    }

}
