//
//  ViewController.swift
//  iQuiz
//
//  Created by Matthew Karyadi on 5/9/22.
//

import UIKit
//class TableViewDelegate : NSObject, UITableViewDataSource, UITableViewDelegate {
//    let data : [String] = [
//    "Math","Marvel Super Heros", "Science"
//    ]
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//
//
//}



class ViewController: UIViewController {
    
    
    @IBAction func settingsPressed(_ sender: Any) {
    }
    
    @IBOutlet weak var quizTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

