//
//  ViewController.swift
//  week8
//
//  Created by 김나현 on 2022/11/14.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var orangeView: UIView!
    @IBOutlet weak var orangeViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var orangeViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var orangeViewTapGestureRecognizer: UITapGestureRecognizer!
    var flag = false
    
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        orangeViewTapGestureRecognizer.addTarget(self, action:
            #selector(orangeViewDidTap))
    }
    
    // MARK: - Functions
    @IBAction func buttonDidTap(_ sender: Any) {
        UIView.animate(
            withDuration: 3,
            animations: {
                self.orangeViewTopConstraint.constant = 50
                self.orangeViewHeightConstraint.constant = 500
                self.view.layoutIfNeeded() // UI 관련된 변경사항 업데이트 필요 (반영)
                self.view.setNeedsDisplay()
            
            }
        )
    }
    
    @objc func orangeViewDidTap() {
        if !flag {
            UIView.animate(
                withDuration: 3,
                animations: {
                    self.orangeViewTopConstraint.constant = 50
                    self.orangeViewHeightConstraint.constant = 500
                    self.view.layoutIfNeeded() // UI 관련된 변경사항 업데이트 필요 (반영)
                    self.view.setNeedsDisplay()
                
                },
                completion: { _ in // 마지막으로 하고 싶은 작업
                    self.flag = true
                }
            )
        }
        else {
            UIView.animate(
                withDuration: 3,
                animations: {
                    self.orangeViewTopConstraint.constant = 199
                    self.orangeViewHeightConstraint.constant = 128
                    self.view.layoutIfNeeded() // UI 관련된 변경사항 업데이트 필요 (반영)
                    self.view.setNeedsDisplay()
                },
                completion: { _ in // Closer
                    self.flag = false
                }
            )
        }
        
    }
    
}
