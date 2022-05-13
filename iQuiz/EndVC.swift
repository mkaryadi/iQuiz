//
//  EndVC.swift
//  iQuiz
//
//  Created by Matthew Karyadi on 5/12/22.
//

import UIKit

class EndVC: UIViewController {
    
    var numCorrect = 0
    var numQuestions = 0

    @IBOutlet weak var numCorrectLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    
    @IBAction func back(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        numCorrectLabel.text = "\(numCorrect) of \(numQuestions) correct!"
        if numCorrect == numQuestions {
            descLabel.text = "Perfect!"
        } else if numCorrect == numQuestions - 1 {
            descLabel.text = "Almost!"
        } else {
            descLabel.text = "Better luck next time!"
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
