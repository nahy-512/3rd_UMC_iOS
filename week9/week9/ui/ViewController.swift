//
//  ViewController.swift
//  week9
//
//  Created by 김나현 on 2022/11/21.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userProfileImageView: UIImageView!
    
    var userName = "oo 님" // default값
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getStationData() // 서버 통신
        
        registerNib()
        
        
    }
    
    private func registerNib() { // Nib 등록
        let nibName = UINib(nibName: SubwayTableViewCell.identifier, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: SubwayTableViewCell.identifier)
        
        //userNameLabel.text = userName + "님"
        userProfileImageView.isHidden = true
    }
    
    // MARK: - 서버 통신
    func getStationData() {
        
        // http 요청 주소 지정
        let url = "http://apis.data.go.kr/1613000/SubwayInfoService/getKwrdFndSubwaySttnList"
        
        // http 요청 헤더 지정
        let header : HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        
        // http 파라미터 지정
        let subwayStationName = searchBar.text // 지하철역 이름 검색
        let serviceKeyString = "1QhfudsF%2Be7Ht4%2B%2B9WqK4VFSQv6MO3k4u9K7VRwZtEo1G0qenyph3vqtV%2Bts5FuOSCaPVYXtBU%2FXlkemtOPDVg%3D%3D"
        
        let params : Parameters = [
            "serviceKey" : serviceKeyString,
            "_type" : "json",
            "subwayStationName" : "서울"
        ]
        //print("입력한 역: \(subwayStationName)")
        
        // httpBody에 parameters 추가
        AF.request(
            url, // 주소
            method: .get, // 전송 타입
            parameters: params, // 파라미터
            encoding: JSONEncoding.default, // 인코딩 스타일
            headers: header // 헤더 지정
        )
        .validate(statusCode: 200..<300)
        .responseData { response in
            switch response.result {
            case .success(let res):
                do {
                    let data = try JSONDecoder().decode(DataModel.self, from: res).response
                    
                    print(data.header.resultCode,data.header.resultMsg)
                    
                    if data.header.resultCode == "00" { // 성공 코드
                        print("지하철 정보 불러오기를 성공했습니다.")
                        let stationData = StationData.shared
                        
                        // 값 넣어주기
                        stationData.stationDataModel = data.body.items.item
                        self.tableView.reloadData()
                    }
                }
                catch {
                    print("지하철 정보 불러오기 실패")
                }
            case .failure(let err):
                
                print(err)
            }
        }
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
                                                        "SubwayTableViewCell", for: indexPath) as?
                SubwayTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
}
