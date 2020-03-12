//
//  SearchViewController.swift
//  EnginnerApp
//
//  Created by majkel on 24.01.2018.
//  Copyright © 2018 majkel. All rights reserved.
//

import UIKit
import  QRCode
class SearchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
var thinkToSearch = ""
     var circle : Array<CircleModel> = Array<CircleModel>()
    var top : Array<TopicModel> = Array<TopicModel>()
var id = 1
    @IBAction func searchClick(_ sender: Any) {
        if thinkToSearch == "topic" {
    
            searchTopic(howMany: String(10), name: searchTextField.text!, id: String(id)){ circle in DispatchQueue.main.async {
                self.top = circle
                self.topicTableView.reloadData()
                
                }
            }}
        if thinkToSearch == "circle" {
    
            searchCircle(howMany: String(10), name: searchTextField.text!, description: searchTextField.text!){circle in
                DispatchQueue.main.async {
                    self.circle = circle
                    self.circleTableView.reloadData()
                    
                }
                
            }
        }

        
        
        
    }
    @IBOutlet weak var qrGeneratedView: UIView!
    @IBOutlet weak var qrGenerated: UIImageView!
    
    @IBAction func dissQr(_ sender: Any){
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
    
    
    
    @IBAction func dissClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circleTableView.delegate = self
        circleTableView.dataSource = self
        topicTableView.delegate = self
        topicTableView.dataSource = self
        circleTableView
            .estimatedRowHeight = 44.0
        circleTableView.rowHeight = UITableViewAutomaticDimension
        
        
        topicTableView.estimatedRowHeight = 44.0
        topicTableView.rowHeight = UITableViewAutomaticDimension
        
        if thinkToSearch == "topic" {
        circleTableView.isHidden = true
        topicTableView.isHidden = false
         }
        if thinkToSearch == "circle" {
            circleTableView.isHidden = false
            topicTableView.isHidden = true
    
            }
    
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CustomCell
        
        if tableView == self.circleTableView {
            cell.NumberFollowerLabelCircle.text = String(circle[indexPath.item].countSubbed)
            
            let date = String(describing: (circle[indexPath.item].publishDate))
            let str = date.substring(to: date.index(date.startIndex, offsetBy: 11))
            
            cell.DateLabelCircle.text = str            
            qrt = "circle"
            cell.circleSearchShare.tag = indexPath.item
            cell.circleSearchShare.addTarget(self, action: #selector(SearchViewController.shareButton), for: .touchUpInside)
            
            
            var encoded  = circle[indexPath.item].author.avatar as String
            if encoded.characters.count > 1 {
                if encoded.characters.count > 100 {
                    let ind = encoded.startIndex
                    encoded = encoded[encoded.index(ind,offsetBy: 22) ..< encoded.endIndex ]
                    
                    if let imageData = Data(base64Encoded: encoded , options: .ignoreUnknownCharacters){
                        let image = UIImage(data : imageData as Data)
                        cell.ImageViewCircle.image = image
                        
                    }
                }
                else {
                    let  url = URL(string: encoded)
                    
                    let data = try? Data(contentsOf: url!)
                    cell.ImageViewCircle.image = UIImage(data: data!)
                }
            }
            cell.NumberTopicsLabelCircle.text = String(circle[indexPath.item].countTopic)
            cell.AuthorLabelCircle.text = circle[indexPath.item].author.lastName
            cell.ContentLabelCircle.text = circle[indexPath.item].description
            cell.ContentLabelCircle.sizeToFit()
            cell.NameLabelCircle.text = circle[indexPath.item].name
            cell.ImageViewCircle.layer.cornerRadius = cell.ImageViewCircle.frame.size.width / 2
            cell.ImageViewCircle.clipsToBounds = true
            cell.cardViewCircle()
            
            
        }
        if tableView == self.topicTableView {
              qrt = "topic"
            cell.topicSearchShare.tag = indexPath.item
            cell.topicSearchShare.addTarget(self, action: #selector(SearchViewController.shareButton), for: .touchUpInside)
          cell.CountSubTopic.text = String(top[indexPath.item].countSubbed)
            
            let date = String(describing: (top[indexPath.item].publishDate))
            let str = date.substring(to: date.index(date.startIndex, offsetBy: 11))
            
            
            cell.dateTopic.text = str
            cell.nameTopic.text = top[indexPath.item].name
            cell.countAnswTopic.text = String(top[indexPath.item].countAnswer)
            cell.contentTopic.text = top[indexPath.item].description
            cell.authorTopic.text = top[indexPath.item].author.lastName
            cell.cardViewTopic()
            
            var encoded  = top[indexPath.item].author.avatar as String
            if encoded.characters.count > 1 {
                if encoded.characters.count > 100 {
                    let ind = encoded.startIndex
                    encoded = encoded[encoded.index(ind,offsetBy: 22) ..< encoded.endIndex ]
                    
                    if let imageData = Data(base64Encoded: encoded , options: .ignoreUnknownCharacters){
                        let image = UIImage(data : imageData as Data)
                        cell.imageTopic.image = image
                        
                    }
                }
                else {
                    let  url = URL(string: encoded)
                    
                    let data = try? Data(contentsOf: url!)
                    cell.imageTopic.image = UIImage(data: data!)
                }
                cell.imageTopic.layer.cornerRadius = cell.imageTopicSub.frame.size.width / 2
                cell.imageTopic.clipsToBounds = true}
        }
        
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.circleTableView {   return circle.count
        }
        else
        {
            return top.count
        }
        
    }

    var typeSeg = ""
    //answerSegue
    var row : String?
    var isSubC : Int?
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        // let e = ExampleMessengerViewController()
        // e.bootstrapWithRandomMessages = 6
        //  navigationController?.pushViewController(e, animated: true)
        //   present(e,animated:true,completion:nil)
        
        if tableView == self.circleTableView {
            row = circle[indexPath.item].name
            id = circle[indexPath.item].idCircle
            isSubC = circle[indexPath.item].isSubbed
            thinkToSearch = "circle"
            performSegue(withIdentifier: "searchTopicInCircleSegue", sender: self)
        }
        if tableView == self.topicTableView {
            row = top[indexPath.item].name
            id = top[indexPath.item].idCircle
            isSubC = top[indexPath.item].isSubbed
            thinkToSearch = "topic"
            performSegue(withIdentifier: "searchAnswerInTopicSegue", sender: self)
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if thinkToSearch == "circle"{
            let dest: TopicViewController = segue.destination as! TopicViewController
            dest.idCircle = id
            dest.nameCircle = row!
            dest.isSubC = isSubC!
            
            
        }
        if thinkToSearch == "topic"{
            let dest: AnswerViewController = segue.destination as! AnswerViewController
            dest.idTopic = id
            dest.nameTopic = row
            dest.isSub = isSubC
        }
    }
    

    @IBOutlet weak var circleTableView: UITableView!

    @IBOutlet weak var topicTableView: UITableView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
