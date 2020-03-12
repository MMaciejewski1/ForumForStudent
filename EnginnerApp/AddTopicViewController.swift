//
//  AddTopicViewController.swift
//  EnginnerApp
//
//  Created by majkel on 20.01.2018.
//  Copyright © 2018 majkel. All rights reserved.
//

import UIKit

class AddTopicViewController: UIViewController {
var id : Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var contentTextField: UITextField!
    
    @IBAction func sendClick(_ sender: Any) {
        let str = nameTextField.text! as String
        let str2 = contentTextField.text! as String
        
        if str.characters.count > 2 && str2.characters.count > 2{
        
            
          
    print(id!)
       
            
            if let presenter = presentingViewController as? TopicViewController {
              addTopic(name: nameTextField.text!,id : id!,description: contentTextField.text!){c in
                
                presenter.top = c + presenter.top
                presenter.topicTableView.reloadData()
                }
                
                
            
            
            }
             dismiss(animated: true, completion: nil)
        
        }
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
