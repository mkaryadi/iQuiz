//
//  QuestionVC.swift
//  iQuiz
//
//  Created by Matthew Karyadi on 5/12/22.
//

import UIKit

class QuestionVC: UIViewController {
    
    var selected = -1
    var questionSet: QuizSet! = nil
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
        answerBuilder(selected == questionSet.questions[questionNumber].correct)
        answerViewController.view.frame = view.frame
        present(answerViewController, animated: true)
    }
    

    
    
    fileprivate func answerBuilder(_ correct: Bool) {
        if answerViewController == nil {
            answerViewController = (storyboard?.instantiateViewController(withIdentifier: "Answer") as! AnswerVC)
            answerViewController.questionSet = questionSet
            answerViewController.questionNumber = questionNumber
            if correct {
                answerViewController.numCorrect = numCorrect + 1
            }
            else {
                answerViewController.numCorrect = numCorrect
            }
            answerViewController.correct = correct
        }
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()
        // Do any additional setup after loading the view.
        selected = -1
        questionLabel.text = questionSet.questions[questionNumber].question
        for i in 0...3 {
            buttons[i].setTitle(questionSet.questions[questionNumber].answers[i], for: .normal)
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
