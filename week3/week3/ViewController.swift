//
//  ViewController.swift
//  week3
//
//  Created by 김나현 on 2022/10/04.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    
    @IBOutlet weak var CalculatorBtn: UIButton! // 선택한 연산 기호 표시
    @IBOutlet weak var ResultLabel: UILabel!
    
    var calculator: Int = 0 // 연산 기호 종류 구별
    var result : Int = 0 // 계산 결과
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("첫 번째 화면: viewDidLoad")
    }

    
    // "=" 버튼 클릭 화면 전환
    @IBAction func buttonDidTab(_ sender: Any) {
        guard let nextViewController = UIStoryboard(name:
            "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "SecondVC") as?
            SecondViewController else { return }
        
        Calculation() // 연산
        ResultLabel.text = String(result) // 결과 반영
        ResultLabel.textColor = UIColor.black
        
        nextViewController.resultString = String(result) // 계산 결과 담았음
        
        // 화면 전환
        nextViewController.modalPresentationStyle = .formSheet
        present(nextViewController, animated: true)
    }
    
    
    @IBAction func PlusBtn(_ sender: Any) {
        calculator = 1
        CalculatorBtn.setTitle("+", for: .normal)
    }
    
    @IBAction func MinusBtn(_ sender: Any) {
        calculator = 2
        CalculatorBtn.setTitle("-", for: .normal)
    }
    
    @IBAction func MulitplicationBtn(_ sender: Any) {
        calculator = 3
        CalculatorBtn.setTitle("x", for: .normal)
    }
    
    @IBAction func DivisionBtn(_ sender: Any) {
        calculator = 4
        CalculatorBtn.setTitle("÷", for: .normal)
    }
    
    
    // 연산자 실행
    func Calculation() {
        print(calculator)
        
        // 입력한 숫자 받아오기
        guard let firstNumber = firstTextField.text else { return }
        guard let secondNumber = secondTextField.text else { return }
        
        // 계산 결과 담기
        if (calculator == 1) { // 덧셈
            result = Int(firstNumber)! + Int(secondNumber)!
        }
        else if (calculator == 2) { // 뺄셈
            result = Int(firstNumber)! - Int(secondNumber)!
        }
        else if (calculator == 3) { // 곱셈
            result = Int(firstNumber)! * Int(secondNumber)!
        }
        else if (calculator == 4) { // 나눗셈
            result = Int(firstNumber)! / Int(secondNumber)!
        }
    }

}

