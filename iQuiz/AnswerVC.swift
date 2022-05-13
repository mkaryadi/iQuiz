//
//  AnswerVC.swift
//  iQuiz
//
//  Created by Matthew Karyadi on 5/12/22.
//

import UIKit

class AnswerVC: UIViewController {

    var correct = false
    var answer = "Test Answer"
    var questionNumber = 0
    var questionViewController : QuestionVC! = nil
    var questions : [String] = []
    var numCorrect = 0
    var answers : [[String]] = []
    var indexs : [Int] = []
    
    @IBOutlet weak var correctImage: UIImageView!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var correctLabel: UILabel!
    
    @IBAction func next(_ sender: Any) {
        if questionNumber < questions.count - 1 {
            questionBuilder()
            present(questionViewController, animated: true)
        }
        else {
            let endViewController = storyboard?.instantiateViewController(withIdentifier: "End") as! EndVC
            endViewController.numCorrect = numCorrect
            endViewController.numQuestions = questions.count
            present(endViewController, animated: true)
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    fileprivate func questionBuilder() {
        if questionViewController == nil {
            questionViewController = (storyboard?.instantiateViewController(withIdentifier: "Question") as! QuestionVC)
            questionViewController.questions = questions
            questionViewController.questionNumber = questionNumber + 1
            questionViewController.numCorrect = numCorrect
            questionViewController.answers = answers
            questionViewController.correctIndex = indexs
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        questionLabel.text = questions[questionNumber]
        answerLabel.text = "Correct answer: " + answer
        if !correct {
            correctImage.image = UIImage(systemName: "xmark")
            correctLabel.text = "Incorrect :("
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
