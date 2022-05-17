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
    var questionSets : [QuizSet] = []
    fileprivate var questionViewController : QuestionVC!

    func fetchQuizes(_ url: URL) {
        print("Started fetching...")
        let session = URLSession.shared.dataTask(with: url) {
            data, response, error in

            if response != nil {
                if (response as! HTTPURLResponse).statusCode != 200 {
                    print("Something went wrong!")
                }
            }
            
            if data != nil {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!)
                    if let arr = json as? [[String: Any]] {
                        for questionSet in arr {
                            let title = questionSet["title"] as? String
                            let desc = questionSet["desc"] as? String
                            let questionsObj = questionSet["questions"] as? [[String: Any]]
                            var questionArray : [Question] = []
                            for question in questionsObj! {
                                let text = question["text"] as! String
                                let answers = question["answers"] as! [String]
                                let correct = Int(question["answer"] as! String)! - 1
                                questionArray.append(Question(question: text, answers: answers, correct: correct))
                            }
                            self.questionSets.append(QuizSet(topic: title!, desc: desc!, questions: questionArray))
                            
                        }
                    }
                    print("Finished fetching successfully!")
                }
                catch {
                    print("Something went wrong with JSON proccessing")
                }
            } else {
                print("Something went wrong with fetching!")
            }
        }
        session.resume()
    }
    
    
    let data : [String] = [
        "Math", "Marvel Super Heros", "Science"
    ]
    
    let images : [UIImage] = [
        UIImage(systemName: "textformat.123")!, UIImage(systemName: "bolt.fill")!, UIImage(systemName: "testtube.2")!
    ]
    
    let desc : [String] = [
        "Quick, what's 2+2?", "Test your knowledge of Mavel's heroes!", "Scientific questions!"
    ]
    
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
        return questionSets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topic", for: indexPath)
        
        cell.textLabel!.text = questionSets[indexPath.row].topic
        cell.detailTextLabel!.text = questionSets[indexPath.row].desc
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        questionBuilder(indexPath.row)
        vc!.show(questionViewController, sender: vc)
        self.table!.deselectRow(at: indexPath, animated: true)
    }
    
    fileprivate func questionBuilder(_ choice: Int) {
        questionViewController = (vc!.storyboard?.instantiateViewController(withIdentifier: "Question") as! QuestionVC)
        questionViewController.questionSet = questionSets[choice]
    }
}

protocol SettingsDelegate {
    func update(_ url: URL)
}

class ViewController: UIViewController, SettingsDelegate {

    

    
    var tableViewDelegateAndDataSource = TableViewDelegateAndDataSource()
    
    @IBAction func settingsPressed(_ sender: Any) {
        let settings = storyboard?.instantiateViewController(withIdentifier: "Settings") as! SettingsVC
        settings.delegate = self
        present(settings, animated: true)
    }
    @IBOutlet weak var quizTable: UITableView!
    var url = URL(string: "https://tednewardsandbox.site44.com/questions.json")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableViewDelegateAndDataSource.vc = self
        tableViewDelegateAndDataSource.table = quizTable
        quizTable.dataSource = tableViewDelegateAndDataSource
        quizTable.delegate = tableViewDelegateAndDataSource
        tableViewDelegateAndDataSource.fetchQuizes(url!)
    }

    func update(_ url: URL) {
        tableViewDelegateAndDataSource.fetchQuizes(url)
        print("Updated!")
    }
}

