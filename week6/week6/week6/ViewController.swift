//
//  ViewController.swift
//  week6
//
//  Created by 김나현 on 2022/10/31.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var decimalLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var firstView: UIView!
    
    @IBOutlet var uiViewTapGestureRecognizer: UITapGestureRecognizer!
    
    @IBOutlet weak var uiViewLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var uiViewTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var buttonStackView: UIStackView!
    
    var mainTimer:Timer? // 타이머
    var timeCount = 0
    var saveTime = 0
    
    var colorList: [UIColor] = [
        .blue,
        .brown,
        .black,
        .cyan,
        .gray,
        .darkText,
        .yellow,
        .red,
        .systemPink,
        .green,
    ]
    
    
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeSetting() // 이전 데이터 가져오기
        
        makeView()
        
        setButton(button: startButton, tag: .start)
        
        setButton(button: checkButton, tag: .check)
        
        setButton(button: stopButton, tag: .stop)
        
        setButton(button: resetButton, tag: .reset)
        checkButton.isEnabled = false
        
        threadTest()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        // 애니메이션
        uiViewTapGestureRecognizer.addTarget(self, action: #selector(uiViewDidTap))
        
//        let tap = UIGestureRecognizer(target: self, action: #selector(stackViewDidPan))
//            buttonStackView.addGestureRecognizer(tap)
    
    }
    
    
    // MARK: - Functions
    
    @objc func buttonAction(_ button:UIButton) {
        
        if let select = ButtonTag(rawValue: button.tag) {
            
            switch select {
            case .start: startAction()
            case .check: checkAction()
            case .reset: resetAction()
            case .stop : stopAction()
            }
            
        } else {
            print("존재하지 않는 태그를 가진 버튼을 입력했습니다")
        }
    }
    
    // 애니메이션
    @objc func uiViewDidTap() {
        UIView.animate(
            withDuration: 2,
            animations: {
                self.uiViewLeadingConstraint.constant = 80
                self.uiViewTrailingConstraint.constant = -80
                self.view.layoutIfNeeded()
            }
        )
    }
                                  
    @objc func stackViewDidPan() {
            UIView.animateKeyframes(
                withDuration: 3, delay: 0.0, animations: {
                    self.buttonStackView.frame = CGRect(x: 25, y: 450, width: 320, height: 30)
                }
                )
//        UIView.animate(
//            withDuration: 3,
//            animations:{
//                self.
//            }
//        )
    }
                                
    
    func makeView() {
        let systemWidth = UIScreen.main.bounds.width
        
        let view = UIView(frame: CGRect(x: systemWidth/2 - 50, y: 200, width: 100, height: 100))
        view.backgroundColor = UIColor.lightGray
        // view.layer.cornerRadius = view.frame.height / 2
        
        self.view.addSubview(view)
        
        animation(view)
    }
    
    func startAction() {
        print("start")
        startButton.isEnabled = false
        checkButton.isEnabled = true
        stopButton.isEnabled = true
        
        var saveTime = UserDefaults.standard.integer(forKey: "timeCount")
        
        self.timeCount = saveTime
        
        mainTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (_) in
            
            self.timeCount += 1
            
            DispatchQueue.main.async {
                
                let timeString = self.makeTimeLabel(count: self.timeCount)
                self.timeLabel.text = timeString.0
                self.decimalLabel.text = ".\(timeString.1)"
                
            }
            
        })
    }
    
    func checkAction() {
        print("check")
    }
    
    func stopAction() {
        print("stop")
        // stop시 타이머 죽이기
        mainTimer?.invalidate()
        mainTimer = nil
        startButton.isEnabled = true
        checkButton.isEnabled = false
        stopButton.isEnabled = false
        
        saveTimeState() // 시간 저장
    }
    
    func resetAction() {
        print("reset")
        mainTimer?.invalidate()
        mainTimer = nil
        timeCount = 0
        timeLabel.text = "00:00"
        decimalLabel.text = ".0"
        startButton.isEnabled = true
        checkButton.isEnabled = false
        stopButton.isEnabled = true
        
        saveTimeState() // 시간 저장
    }
    
    func saveTimeState() {
        UserDefaults.standard.set(timeCount, forKey: "timeCount")
        print("저장: \(UserDefaults.standard.integer(forKey: "timeCount"))")
    }
    
    func timeSetting() {
        // 저장된 스톱워치 시간 확인
        print("setting")
        
        var saveTime = UserDefaults.standard.integer(forKey: "timeCount")
        
        print(saveTime)
        
        DispatchQueue.main.async {
            
            let timeSetting = self.makeTimeLabel(count: saveTime)
            
            print(timeSetting)
            self.timeLabel.text = timeSetting.0
            self.decimalLabel.text = ".\(timeSetting.1)"
            
        }
    }
    
    func makeTimeLabel(count:Int) -> (String,String) {
        //return - (TimeLabel, decimalLabel)
        let decimalSec  = count % 10
        let sec = (count / 10) % 60
        let min = (count / 10) / 60
        
        let sec_string = "\(sec)".count == 1 ? "0\(sec)" : "\(sec)"
        let min_string = "\(min)".count == 1 ? "0\(min)" : "\(min)"
        return ("\(min_string):\(sec_string)","\(decimalSec)")
    }
    
    func setButton(button : UIButton, tag : ButtonTag){
        
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        
        button.tag = tag.rawValue
        
    }
    
    func animation(_ view: UIView) {
        
        let scaleAnimation = CGAffineTransform(scaleX: 2.0, y: 2.0)
        let rotateAnimation = CGAffineTransform(rotationAngle: .pi)
        let moveAnimation = CGAffineTransform(translationX: 0, y: 150)
        
        let concat = scaleAnimation.concatenating(rotateAnimation).concatenating(moveAnimation)
        
        UIView.animate(withDuration: 1, delay: 1, options: [], animations: {
            
            view.transform = concat
        }, completion: nil)
    }
    
    //    @IBAction func startButton(_ sender: UIButton) {
    //        print(sender.tag)
    //    }
    //
    //    @IBAction func checkButton(_ sender: UIButton) {
    //    }
    //
    //    @IBAction func stopButton(_ sender: UIButton) {
    //
    //    }
    //    @IBAction func resetButton(_ sender: UIButton) {
    //    }
    
    func threadTest() {
        DispatchQueue.global().async {
            for color in self.colorList {
                DispatchQueue.main.sync {
                    self.firstView.backgroundColor = color
                }
                sleep(1)
            }
        }
        //        DispatchQueue.global().async {
        //            for color in self.colorList.reversed() {
        //                DispatchQueue.main.sync {
        //                    self.secondView.backgroundColor = color
        //                }
        //                sleep(1)
        //            }
        //        }
        //        DispatchQueue.global().async {
        //            for i in 1...10 {
        //                print(i)
        //            }
        //        }
        //
        //        DispatchQueue.global().async {
        //            for i in 11...20 {
        //                print(i)
        //            }
        //        }
    }
    
    enum ButtonTag : Int {
        
        case start = 10
        case check = 20
        case stop = 30
        case reset = 40
        
    }
}

