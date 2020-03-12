//
//  SubViewController.swift
//  EnginnerApp
//
//  Created by majkel on 21.01.2018.
//  Copyright © 2018 majkel. All rights reserved.
//

import UIKit
import QRCode
class SubViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var topicSubTableView: UITableView!
    @IBOutlet weak var circleSubTableView: UITableView!
    
    var topic : Array<TopicModel> = Array<TopicModel>()
    var circle: Array<CircleModel> = Array<CircleModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topicSubTableView.delegate = self
        topicSubTableView.dataSource = self
        circleSubTableView.delegate = self
        circleSubTableView.dataSource = self
        subCircleList(){ circle in
            DispatchQueue.main.async {
                self.circle = circle
                self.circleSubTableView.reloadData()
                
            }

        
        }
        
        subTopicList(){ circle in
            DispatchQueue.main.async {
                self.topic = circle
                self.topicSubTableView.reloadData()
                
            }
            
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CustomCell
      
        if tableView == self.circleSubTableView {
            cell.subCircleSub.text = String(circle[indexPath.item].countSubbed)
            
            let date = String(describing: (circle[indexPath.item].publishDate))
            let str = date.substring(to: date.index(date.startIndex, offsetBy: 11))
            cell.dateCircleSub.text = str
            
            var encoded  = circle[indexPath.item].author.avatar as String
            if encoded.characters.count > 1 {
            if encoded.characters.count > 100 {
                let ind = encoded.startIndex
                encoded = encoded[encoded.index(ind,offsetBy: 22) ..< encoded.endIndex ]
                
                if let imageData = Data(base64Encoded: encoded , options: .ignoreUnknownCharacters){
                    let image = UIImage(data : imageData as Data)
                    cell.imageCircleSub.image = image
                    
                }
            }
            else {
                let  url = URL(string: encoded)
                
                let data = try? Data(contentsOf: url!)
                cell.imageCircleSub.image = UIImage(data: data!)
            }
}
            cell.topicCircleSub.text = String(circle[indexPath.item].countTopic)
            cell.authorCircleSub.text = circle[indexPath.item].author.lastName
            cell.contentCircleSub.text = circle[indexPath.item].description
            cell.imageCircleSub.layer.cornerRadius = cell.imageCircleSub.frame.size.width / 2
            cell.imageCircleSub.clipsToBounds = true
cell.cardViewCircleSub()
            qrt = "circle"
            cell.circleShare.tag = indexPath.item
            cell.circleShare.addTarget(self, action: #selector(SubViewController.shareButton), for: .touchUpInside)
        
        }
        if tableView == self.topicSubTableView {
            qrt = "topic"
            cell.subTopicSub.text = String(topic[indexPath.item].countSubbed)
            cell.topicShare.tag = indexPath.item
            cell.topicShare.addTarget(self, action: #selector(SubViewController.shareButton), for: .touchUpInside)
            let date = String(describing: (topic[indexPath.item].publishDate))
            let str = date.substring(to: date.index(date.startIndex, offsetBy: 11))
            cell.dateTopicSub.text = str
            cell.nameTopicSub.text = topic[indexPath.item].name
            cell.answerTopicSub.text = String(topic[indexPath.item].countAnswer)
            cell.contentTopicSub.text = topic[indexPath.item].description
            cell.authorTopicSub.text = topic[indexPath.item].author.lastName
        cell.cardViewTopicSubView()
          
            var encoded  = topic[indexPath.item].author.avatar as String
            if encoded.characters.count > 1 {
            if encoded.characters.count > 100 {
                let ind = encoded.startIndex
                encoded = encoded[encoded.index(ind,offsetBy: 22) ..< encoded.endIndex ]
                
                if let imageData = Data(base64Encoded: encoded , options: .ignoreUnknownCharacters){
                    let image = UIImage(data : imageData as Data)
                    cell.imageTopicSub.image = image
                    
                }
            }
            else {
                let  url = URL(string: encoded)
                
                let data = try? Data(contentsOf: url!)
                cell.imageTopicSub.image = UIImage(data: data!)
            }
                cell.imageTopicSub.layer.cornerRadius = cell.imageTopicSub.frame.size.width / 2
                cell.imageTopicSub.clipsToBounds = true}
        }
       
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     if tableView == self.circleSubTableView {   return circle.count
        }
        else
     {
        return topic.count
        }
        
    }
    var row : String?
    var id : Int?
    var isSubC : Int?
    var check = ""
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        // let e = ExampleMessengerViewController()
        // e.bootstrapWithRandomMessages = 6
        //  navigationController?.pushViewController(e, animated: true)
        //   present(e,animated:true,completion:nil)
        
        if tableView == self.circleSubTableView {
            row = circle[indexPath.item].name
            id = circle[indexPath.item].idCircle
            isSubC = circle[indexPath.item].isSubbed
            check = "circle"
            performSegue(withIdentifier: "circleSubSegue", sender: self)
        }
        if tableView == self.topicSubTableView {
            row = topic[indexPath.item].name
            id = topic[indexPath.item].idTopic
            isSubC = topic[indexPath.item].isSubbed
            check = "topic"
            performSegue(withIdentifier: "topicSubSegue", sender: self)
        }


    }
    
    @IBOutlet weak var qrGenerated: UIImageView!
    
    @IBOutlet weak var qrGeneratedView: UIView!
    
    @IBAction func dissQr(_ sender: Any) {
        qrGeneratedView.isHidden = true
    }
    var qrt = ""
    func shareButton(sender: UIButton){
        let index = sender.tag
        if qrt == "circle"{
        let qrCode = QRCode("DMTAPP;Circle;Red;\(index)")
        qrGenerated.image = qrCode?.image
        qrGeneratedView.isHidden = false
        }
        else {
        //topic
        let qrCode = QRCode("DMTAPP;Topic;Red;\(index)")
        qrGenerated.image = qrCode?.image
        qrGeneratedView.isHidden = false
    }
        }

    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if check == "circle"{
            let dest: TopicViewController = segue.destination as! TopicViewController
            dest.idCircle = id!
            dest.nameCircle = row!
            dest.isSubC = isSubC!

        
        }
        if check == "topic"{
            let dest: AnswerViewController = segue.destination as! AnswerViewController
            dest.idTopic = id
            dest.nameTopic = row
            dest.isSub = isSubC
        }
    }
    
    @IBAction func circleClick(_ sender: Any) {
        topicSubTableView.isHidden = true
        circleSubTableView.isHidden = false
    }
    
    @IBAction func topicClick(_ sender: Any) {
        circleSubTableView.isHidden = true
        topicSubTableView.isHidden = false
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
