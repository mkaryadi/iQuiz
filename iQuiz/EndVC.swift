//
//  EndVC.swift
//  iQuiz
//
//  Created by Matthew Karyadi on 5/12/22.
//

import UIKit

class EndVC: UIViewController {

    @IBAction func back(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true)
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
