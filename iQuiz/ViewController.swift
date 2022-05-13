//
//  ViewController.swift
//  iQuiz
//
//  Created by Matthew Karyadi on 5/9/22.
//

import UIKit


class TableViewDelegateAndDataSource : NSObject, UITableViewDataSource, UITableViewDelegate {
    weak var vc : UIViewController?
    weak var table : UITableView?
    fileprivate var questionViewController : QuestionVC!
     
    let data : [String] = [
        "Math", "Marvel Super Heros", "Science"
    ]
    
    let images : [UIImage] = [
        UIImage(systemName: "textformat.123")!, UIImage(systemName: "bolt.fill")!, UIImage(systemName: "testtube.2")!
    ]
    
    let desc : [String] = [
        "Quick, what's 2+2?", "Test your knowledge of Mavel's heroes!", "Scientific questions!"
    ]
    
    struct QuestionSet {
        var questions : [String]
        var answers : [[String]]
        var index : [Int]
    }
    
    
    var mathQuestions = QuestionSet(questions: ["Math Question 1", "Math Question 2"], answers: [["Test Answer 1", "Test Answer 2", "Test Answer 3", "Test Answer 4"], ["Test Answer 5", "Test Answer 6", "Test Answer 7", "Test Answer 8"]], index: [0, 1])
    
    var marvelQuestions = QuestionSet(questions: ["Super Hero Question 1", "Super Hero Question 2"], answers: [["This is a distinct answer", "So is this", "Cope", "Seethe"], ["Mald", "gg", "no re", "not even close"]], index: [1, 2])
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topic", for: indexPath)
        
        cell.textLabel!.text = data[indexPath.row]
        cell.detailTextLabel!.text = desc[indexPath.row]
        cell.imageView?.image = images[indexPath.row]
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        questionBuilder(indexPath.row)
        vc!.show(questionViewController, sender: vc)
        self.table!.deselectRow(at: indexPath, animated: true)
    }
    
    
    fileprivate func questionBuilder(_ choice: Int) {
        questionViewController = (vc!.storyboard?.instantiateViewController(withIdentifier: "Question") as! QuestionVC)
        switch choice {
        case 0:
            questionViewController.answers = mathQuestions.answers
            questionViewController.correctIndex = mathQuestions.index
            questionViewController.questions = mathQuestions.questions
        default:
            questionViewController.answers = marvelQuestions.answers
            questionViewController.correctIndex = marvelQuestions.index
            questionViewController.questions = marvelQuestions.questions
        }

    }
}



class ViewController: UIViewController {
    
    
    var tableViewDelegateAndDataSource = TableViewDelegateAndDataSource()
    
    
    @IBAction func settingsPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "Settings go here.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    @IBOutlet weak var quizTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableViewDelegateAndDataSource.vc = self
        tableViewDelegateAndDataSource.table = quizTable
        quizTable.dataSource = tableViewDelegateAndDataSource
        quizTable.delegate = tableViewDelegateAndDataSource
    }


}

