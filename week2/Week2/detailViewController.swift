//
//  detailViewController.swift
//  Week2
//
//  Created by 김나현 on 2022/10/02.
//

import UIKit
class DetailViewController : UIViewController {
    
    // 뒤로가기
    @IBAction func backBtn(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
