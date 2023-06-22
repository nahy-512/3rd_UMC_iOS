//
//  ViewController.swift
//  Week2
//
//  Created by 김나현 on 2022/09/29.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func switchBtn(_ sender: Any) {
        guard let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "detailVC") as? DetailViewController else { return }
                // 화면 전환 애니메이션 설정
                secondViewController.modalTransitionStyle = .coverVertical
                // 전환된 화면이 보여지는 방법 설정 (fullScreen)
        
                secondViewController.modalPresentationStyle = .fullScreen
                self.present(secondViewController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}
