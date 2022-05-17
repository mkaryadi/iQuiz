//
//  SettingsVC.swift
//  iQuiz
//
//  Created by Matthew Karyadi on 5/16/22.
//

import UIKit

class SettingsVC: UIViewController {
    
    var delegate : SettingsDelegate? = nil

    @IBOutlet weak var urlBox: UITextField!
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func updatePressed(_ sender: Any) {
        self.delegate?.update(URL(string: urlBox.text!)!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
