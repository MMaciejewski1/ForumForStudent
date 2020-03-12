//
//  EventViewController.swift
//  EnginnerApp
//
//  Created by majkel on 01.02.2018.
//  Copyright © 2018 majkel. All rights reserved.
//

import UIKit
class EventViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource{

    @IBOutlet weak var eventTableView: UITableView!

 var ev : Array<EventModel> = Array<EventModel>()
    override func viewDidLoad() {
        super.viewDidLoad()
        eventTableView.estimatedRowHeight = 44.0
        eventTableView.rowHeight = UITableViewAutomaticDimension
        eventTableView.dataSource = self
        eventTableView.delegate = self
       
        
        eventsTab(){circles in
            DispatchQueue.main.async {
            self.ev = circles
            self.eventTableView.reloadData()
            
            }
        // Do any additional setup after loading the view.
            }}
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (ev.count)
    }

  
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CustomCell
        
        cell.contentEvent.sizeToFit()
        cell.contentEvent.layoutIfNeeded()
        if ev[indexPath.item].type == "Topic"{
        cell.contentEvent.text = ev[indexPath.item].data.author.lastName + " " + ev[indexPath.item].data.author.name + " opublikowal(a) temat \"" + ev[indexPath.item].data.name+"\""
            
            
            let date = String(describing: (ev[indexPath.item].publishDate))
            let str = date.substring(to: date.index(date.startIndex, offsetBy: 11))

            
            cell.dateEvent.text = str
        var encoded  = ev[indexPath.item].data.author.avatar as String
        if encoded.characters.count > 1{
            
            if encoded.characters.count > 100 {
                let ind = encoded.startIndex
                encoded = encoded[encoded.index(ind,offsetBy: 22) ..< encoded.endIndex ]
                
                if let imageData = Data(base64Encoded: encoded , options: .ignoreUnknownCharacters){
                    let image = UIImage(data : imageData as Data)
                    cell.imageEvent.image = image
                    
                }
            }
            else {
                let  url = URL(string: encoded)
                
                let data = try? Data(contentsOf: url!)
                cell.imageEvent.image = UIImage(data: data!)
            }
        }
        cell.imageEvent.layer.cornerRadius = cell.imageEvent.frame.size.width / 2
        cell.imageEvent.clipsToBounds = true
        
        
        }
        
        else {
            cell.contentEvent.text = ev[indexPath.item].data2.author.lastName + " " + ev[indexPath.item].data2.author.name + " opublikowal(a) krag \"" + ev[indexPath.item].data2.name + "\""
           
            
            let date = String(describing: (ev[indexPath.item].publishDate))
            let str = date.substring(to: date.index(date.startIndex, offsetBy: 11))
            
            
            cell.dateEvent.text = str
            var encoded  = ev[indexPath.item].data2.author.avatar as String
            if encoded.characters.count > 1{
                
                if encoded.characters.count > 100 {
                    let ind = encoded.startIndex
                    encoded = encoded[encoded.index(ind,offsetBy: 22) ..< encoded.endIndex ]
                    
                    if let imageData = Data(base64Encoded: encoded , options: .ignoreUnknownCharacters){
                        let image = UIImage(data : imageData as Data)
                        cell.imageEvent.image = image
                        
                    }
                }
                else {
                    let  url = URL(string: encoded)
                    
                    let data = try? Data(contentsOf: url!)
                    cell.imageEvent.image = UIImage(data: data!)
                }
            }
            cell.imageEvent.layer.cornerRadius = cell.imageEvent.frame.size.width / 2
            cell.imageEvent.clipsToBounds = true
            

        
        
        }
        return cell
    }			
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
       //        performSegue(withIdentifier: "eventCircle", sender: self)
        if ev[indexPath.item].type == "Topic"{
            rowT = ev[indexPath.item].data.description
            id = ev[indexPath.item].data.idTopic
            isSubC = ev[indexPath.item].data.isSubbed
            destination = "topic"
            
        performSegue(withIdentifier: "eventTopic", sender: self)
        }
        
        else {
            rowT = ev[indexPath.item].data2.name
            id = ev[indexPath.item].data2.idCircle
            isSubC = ev[indexPath.item].data2.isSubbed
             destination = "circle"
            performSegue(withIdentifier: "eventCircle", sender: self)
       
        }
        
    }
    
    @IBAction func dissClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    var id = 1
    var rowT = ""
    var isSubC = 1
    var destination = ""
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if destination == "topic"  {
   
            let dest: AnswerViewController = segue.destination as! AnswerViewController
            dest.idTopic = id
            dest.nameTopic = rowT
            dest.isSub = isSubC
        }
        
        else {
            let dest: TopicViewController = segue.destination as! TopicViewController
            dest.idCircle = id
            dest.nameCircle = rowT
            dest.isSubC = isSubC
        
        
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
