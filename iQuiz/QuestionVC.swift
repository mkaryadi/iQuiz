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
    var questionNumber = 0
    var correctAnswer = -1
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
        NSLog("Currently Selected: \(selected)")
        buttons[4].isEnabled = true
    }
    
    
    @IBAction func submit(_ sender: Any) {
        //TODO: Check if the answer is right
        answerBuilder()
        answerViewController.view.frame = view.frame
        present(answerViewController, animated: true)
    }
    
    
    fileprivate func answerBuilder() {
        if answerViewController == nil {
            answerViewController = (storyboard?.instantiateViewController(withIdentifier: "Answer") as! AnswerVC)
            answerViewController.questions = questions
            answerViewController.questionNumber = questionNumber
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        selected = -1
        questionLabel.text = questions[questionNumber]
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
