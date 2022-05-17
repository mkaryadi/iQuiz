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
    
//    var mathQuestions = QuestionSet(questions: ["What is 9 + 10?", "How many sides does a nonagon have?"], answers: [["19", "21", "76", "12"], ["16", "9", "654", "An infinite number"]], index: [0, 1])
//
//    var marvelQuestions = QuestionSet(questions: ["Who is the first Avenger?", "What year is New York attacked in \"The Avengers\"?"], answers: [["Iron Man", "Captain America", "The Hulk", "Thor"], ["2008", "2015", "2012", "5000 BC"]], index: [1, 2])
//
//    var scienceQuestions = QuestionSet(questions: ["What is the most abundant element?", "What place is Californium named for?", "How many protons does Oxygen have?"], answers: [["Helium", "Oxygen", "Uranium", "Hydrogen"], ["France", "Brazil", "Antartica", "California"], ["7", "8", "56", "3"]], index: [3,3,1])
    
    var mathQuestions = [
        Question(question: "What is 9 + 10?", answers: ["19", "21", "76", "12"], correct: 0),
        Question(question: "How many sides does a nonagon have?", answers: ["16", "9", "654", "An infinite number"], correct: 1)
    ]
    
    var marvelQuestions = [
        Question(question: "Who is the first Avenger?", answers: ["Iron Man", "Captain America", "The Hulk", "Thor"], correct: 1),
        Question(question: "What year is New York attacked in \"The Avengers\"?", answers: ["2008", "2015", "2012", "5000 BC"], correct: 2)
    ]
    
    var scienceQuestions = [
        Question(question: "What is the most abundant element?", answers: ["Helium", "Oxygen", "Uranium", "Hydrogen"], correct: 3),
        Question(question: "What place is Californium named for?", answers: ["France", "Brazil", "Antartica", "California"], correct: 3),
        Question(question: "How many protons does Oxygen have?", answers: ["7", "8", "56", "3"], correct: 1)
    ]
    
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
            questionViewController.questionSet = QuizSet(topic: "Math", questions: mathQuestions)
        case 1:
            questionViewController.questionSet = QuizSet(topic: "Marvel", questions: marvelQuestions)
        default:
            questionViewController.questionSet = QuizSet(topic: "Science", questions: scienceQuestions)
        }

    }
}



class ViewController: UIViewController {
    
    
    var tableViewDelegateAndDataSource = TableViewDelegateAndDataSource()
    
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

