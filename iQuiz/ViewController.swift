//
//  ViewController.swift
//  iQuiz
//
//  Created by Matthew Karyadi on 5/9/22.
//

import UIKit
import Foundation
import Network

class TableViewDelegateAndDataSource : NSObject, UITableViewDataSource, UITableViewDelegate {
    weak var vc : ViewController?
    weak var table : UITableView?
    var questionSets : [QuizSet] = []
    fileprivate var questionViewController : QuestionVC!
    var networkReachable = false
    private var monitor = NWPathMonitor()
    private var queue = DispatchQueue.global(qos: .background)
    
    override init() {
        monitor = NWPathMonitor()
        queue = DispatchQueue.global(qos: .background)
        monitor.start(queue: queue)
    }
    
    func startMonitoring() {
        monitor.pathUpdateHandler = {path in
            if path.status == .satisfied {
                print("We've got a connection!")
            } else {
                print("No internet :(")
            }
        }
    }
    
    
    func fetchQuizes(_ url: URL) {
        if monitor.currentPath.status == .satisfied {
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
                        self.questionSets = []
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
                        print("Finished fetching, updating table...")
                        DispatchQueue.main.async {
                            let fm = FileManager.default
                            self.table?.reloadData()
                            let nsQuestionSets = self.questionSets as NSArray
                            let archivePath = fm.urls(for: .documentDirectory, in: .userDomainMask)[0]
                            let fullPath = archivePath.appendingPathComponent("quizzes.plist")
                            do {
                                let data = try NSKeyedArchiver.archivedData(withRootObject: nsQuestionSets, requiringSecureCoding: false)
                                try data.write(to: fullPath)
                            } catch {
                                print("whoops")
                            }
                        }
                    }
                    catch {
                        print("Something went wrong with fetching!")
                    }
                } else {
                    print("Something went wrong with fetching!")
                }
            }
            session.resume()
        } else {
            let alert = UIAlertController(title: "No internet access!", message: "The internet cannot be reached.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            vc!.present(alert, animated: true)
        }
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


class ViewController: UIViewController{

    
    var tableViewDelegateAndDataSource = TableViewDelegateAndDataSource()
    
    @IBAction func settingsPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "Quiz URL:", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.keyboardType = .URL
            textField.text = self.url.absoluteString
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            let link = URL(string: alert.textFields![0].text!)!
            self.url = link
            self.update(link)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        self.present(alert, animated: true)
    }
    @IBOutlet weak var quizTable: UITableView!
    var url = URL(string: "https://tednewardsandbox.site44.com/questions.json")!
    let fm = FileManager.default

    override func viewDidLoad() {
        let defaultQuestions = [
            QuizSet(topic: "Math", desc: "What's 2+2?", questions: tableViewDelegateAndDataSource.mathQuestions),
            QuizSet(topic: "Marvel", desc: "Super Heroes!", questions: tableViewDelegateAndDataSource.mathQuestions),
            QuizSet(topic: "Science", desc: "Elements and more!", questions: tableViewDelegateAndDataSource.scienceQuestions)]
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableViewDelegateAndDataSource.vc = self
        tableViewDelegateAndDataSource.table = quizTable
        quizTable.dataSource = tableViewDelegateAndDataSource
        quizTable.delegate = tableViewDelegateAndDataSource
        
        let docURL = fm.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fullURL = docURL.appendingPathComponent("quizzes.plist")
        tableViewDelegateAndDataSource.questionSets = (NSKeyedUnarchiver.unarchiveObject(withFile: fullURL.path) as? [QuizSet]) ?? defaultQuestions
        tableViewDelegateAndDataSource.startMonitoring()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableViewDelegateAndDataSource.fetchQuizes(url)
    }
    
    func update(_ url: URL) {
        self.url = url
        tableViewDelegateAndDataSource.fetchQuizes(url)
    }
}

