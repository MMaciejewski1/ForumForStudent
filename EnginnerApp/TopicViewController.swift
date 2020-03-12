//
//  TopicViewController.swift
//  EnginnerApp
//
//  Created by majkel on 08.01.2018.
//  Copyright © 2018 majkel. All rights reserved.
//

import UIKit
import  QRCode
class TopicViewController: UIViewController,UITableViewDelegate,UITableViewDataSource   {
    var refresher : UIRefreshControl!
    var top : Array<TopicModel> = Array<TopicModel>()
    @IBOutlet weak var topicTableView: UITableView!
    var idCircle = Int()
    var nameCircle = String()
    var isSubC = Int()
    var images = [#imageLiteral(resourceName: "star.png"),#imageLiteral(resourceName: "star1600.png")]
       override func viewDidLoad() {
        super.viewDidLoad()
        topicTableView.estimatedRowHeight = 44.0
        topicTableView.rowHeight = UITableViewAutomaticDimension
        
        topicLimit(howMany: "10",id: idCircle, date: Date())
        { circles in
            
            DispatchQueue.main.async {
                self.top = circles
                self.topicTableView.reloadData()
               
            }
        }
topicTableView.delegate = self
        topicTableView.dataSource = self
        
        if(isSubC == 0)
        {  subImage.setImage(images[1], for: UIControlState.normal) }
        else { subImage.setImage(images[0], for: UIControlState.normal)}
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Przeciagnij by odswiezyc")
        refresher.addTarget(self, action: #selector(TopicViewController.populate), for: UIControlEvents.valueChanged)
  topicTableView.addSubview(refresher)
    }

    
    @IBAction func dissQr(_ sender: Any) {
         qrGeneratedView.isHidden = true
    }
    func shareButton(sender: UIButton){
        let index = sender.tag
        let qrCode = QRCode("DMTAPP;Topic;Red;\(index)")
        qrGenerated.image = qrCode?.image
        qrGeneratedView.isHidden = false
    }

    @IBOutlet weak var qrGeneratedView: UIView!
    @IBOutlet weak var qrGenerated: UIImageView!
    
    @IBOutlet weak var subImage: UIButton!
        // Do any additional setup after loading the view.
    @IBAction func subClick(_ sender: Any) {
    
        if(isSubC == 1)
        {
            isSubC = 0
            subImage.setImage(images[1], for: UIControlState.normal)
            subCircle(id: String(idCircle), status: true)
            
        }
        else
        {
            isSubC = 1
            subImage.setImage(images[0], for: UIControlState.normal)
            subCircle(id:String(idCircle), status: false)
            
        }
    }

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (top.count)
    }
    var row = ""
    var id = 1
    var isSub = 1
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CustomCell
    cell.selectionStyle = .none
        cell.topicShareW.tag = indexPath.item
        cell.topicShareW.addTarget(self, action: #selector(TopicViewController.shareButton), for: .touchUpInside)
    
        let datef = DateFormatter()
        datef.dateFormat = "yyyy-mm-dd hh:mm"
        
        var encoded  = top[indexPath.item].author.avatar as String
        if encoded.characters.count > 1{
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
        }
        cell.imageTopic.layer.cornerRadius = cell.imageTopic.frame.size.width / 2
        cell.imageTopic.clipsToBounds = true

        cell.dateTopic.text = datef.string(for: top[indexPath.item].publishDate as Date)
    cell.nameTopic.text = top[indexPath.item].name
        
        cell.authorTopic.text = top[indexPath.item].author.lastName
        cell.contentTopic.text = top[indexPath.item].description
       cell.contentTopic.sizeToFit()
        cell.authorTopic.sizeToFit()
        cell.nameTopic.sizeToFit()
        cell.CountSubTopic.text = String(describing: top[indexPath.item].countAnswer)
        cell.countAnswTopic.text = String(describing: top[indexPath.item].countSubbed)
        cell.cardViewTopic()
     
        if self.top.count > 9
        {
        if indexPath.row == self.top.count - 1
        {
            self.populated()
        }
    }

      return cell
    }
    var typeSeg = ""
    //answerSegue
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        row = top[indexPath.item].description
        id = top[indexPath.item].idTopic
        isSub = top[indexPath.item].isSubbed
         typeSeg = "AnswerViewController"
        check = "ans"
    performSegue(withIdentifier: "answerSegue", sender: self)
       
    
    }
    
    
    @IBOutlet weak var addTopicView: UIView!
    
    @IBAction func dissableAdd(_ sender: Any) {
        addButton.isHidden = false
        searchButton.isHidden = false
        addTopicView.isHidden = true
    }
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBAction func addTopicClick(_ sender: Any) {
        addButton.isHidden = true
        searchButton.isHidden = true
        addTopicView.isHidden = false
       
    }
    
    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var descTextField: UITextView!
    @IBOutlet weak var descText: UITextField!
    var check = ""
    @IBAction func addClick(_ sender: Any) {
        let str = nameText.text! as String
        let str2 = descTextField.text! as String
        if str2.characters.count < 140 {
        if str.characters.count > 4 && str2.characters.count > 5{
            addTopic(name: nameText.text!,id : idCircle,description: descTextField.text!){ circles in
 
                
                self.top =   circles + self.top
                print(circles.description)
                self.topicTableView.reloadData()
                self.addTopicView.isHidden = true
                
               
                self.id = circles[0].idTopic
                self.check = "ans"
                self.performSegue(withIdentifier: "answerSegue", sender: self)
            }
            
            
            }
            
            
        }
        
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if check == "ans"{
        let dest: AnswerViewController = segue.destination as! AnswerViewController
        dest.idTopic = id
        dest.nameTopic = row
        dest.isSub = isSub
        }
         if check == "search" {
            let dest: SearchViewController = segue.destination as! SearchViewController
            dest.id = idCircle
            dest.thinkToSearch = "topic"
        
        
        }
        
    }
    func populated(){
        
        topicLimit(howMany: "10", id:idCircle,date: top[top.count-1].publishDate, completion: { circles in
            
            DispatchQueue.main.async {
                self.top.append(contentsOf:  circles)
                self.topicTableView.reloadData()
                //self.animateIn(f: "CirclesView")
            }
        }
            
        )
     
    }

    
       func populate(){
        topicLimit(howMany: "10", id:idCircle,date: Date(), completion: { circles in
            
            DispatchQueue.main.async {
                self.top.append(contentsOf:  circles)
                self.topicTableView.reloadData()
                //self.animateIn(f: "CirclesView")
            }
        
        }
        )
        refresher.endRefreshing()
    }
    

    @IBAction func searchClick(_ sender: Any) {
        check = "search"
        performSegue(withIdentifier: "searchTopicSegue", sender: self)
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
