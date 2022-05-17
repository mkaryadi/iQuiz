//
//  AnswerVC.swift
//  iQuiz
//
//  Created by Matthew Karyadi on 5/12/22.
//

import UIKit

class AnswerVC: UIViewController {

    var correct = false
    var questionNumber = 0
    var questionSet : QuizSet! = nil
    var questionViewController : QuestionVC! = nil
    var numCorrect = 0
    
    @IBOutlet weak var correctImage: UIImageView!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var correctLabel: UILabel!
    
    @IBAction func next(_ sender: Any) {
        if questionNumber < questionSet.count - 1 {
            questionBuilder()
            present(questionViewController, animated: true)
        }
        else {
            let endViewController = storyboard?.instantiateViewController(withIdentifier: "End") as! EndVC
            endViewController.numCorrect = numCorrect
            endViewController.numQuestions = questionSet.count
            present(endViewController, animated: true)
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    
    fileprivate func questionBuilder() {
        if questionViewController == nil {
            questionViewController = (storyboard?.instantiateViewController(withIdentifier: "Question") as! QuestionVC)
            questionViewController.questionSet = questionSet
            questionViewController.questionNumber = questionNumber + 1
            questionViewController.numCorrect = numCorrect
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        questionLabel.text = questionSet.questions[questionNumber].question
        answerLabel.text = "Correct answer: " + questionSet.questions[questionNumber].correctAnswer
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
