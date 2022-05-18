//
//  SettingsVC.swift
//  iQuiz
//
//  Created by Matthew Karyadi on 5/16/22.
//

import UIKit

class SettingsVC: UIViewController {
    
    var delegate : ViewController?
    var url : URL = URL(string: "http://tednewardsandbox.site44.com/questions.json")!
    @IBOutlet weak var urlBox: UITextField!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func updatePressed(_ sender: Any) {
        self.delegate?.update(URL(string: urlBox.text!)!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        urlBox.text = url.absoluteString
        statusLabel.text = ""   
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
