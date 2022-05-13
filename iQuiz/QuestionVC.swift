//
//  QuestionVC.swift
//  iQuiz
//
//  Created by Matthew Karyadi on 5/12/22.
//

import UIKit

class QuestionVC: UIViewController {
    
    var selected = -1
    var questions : [String] = []
    var answers : [[String]] = []
    var correctIndex : [Int] = []
    var questionNumber = 0
    var numCorrect = 0
    var answerViewController : AnswerVC! = nil
    
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBAction func back(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    @IBAction func buttonPressed(_ sender: UIButton) {
        for button in buttons{
            button.isSelected = false
        }
        sender.isSelected = true
        selected = buttons.firstIndex(of: sender)!
        buttons[4].isEnabled = true
    }
    
    
    @IBAction func submit(_ sender: Any) {
        if selected == correctIndex[questionNumber] {
            numCorrect = numCorrect + 1
        }
        answerBuilder()
        answerViewController.view.frame = view.frame
        present(answerViewController, animated: true)
    }
    

    
    
    fileprivate func answerBuilder() {
        if answerViewController == nil {
            answerViewController = (storyboard?.instantiateViewController(withIdentifier: "Answer") as! AnswerVC)
            answerViewController.questions = questions
            answerViewController.questionNumber = questionNumber
            answerViewController.numCorrect = numCorrect
            answerViewController.answer = answers[questionNumber][correctIndex[questionNumber]]
            answerViewController.correct = (selected == correctIndex[questionNumber])
            answerViewController.answers = answers
            answerViewController.indexs = correctIndex
        }
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()
        // Do any additional setup after loading the view.
        selected = -1
        questionLabel.text = questions[questionNumber]
        for i in 0...3 {
            buttons[i].setTitle(answers[questionNumber][i], for: .normal)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
