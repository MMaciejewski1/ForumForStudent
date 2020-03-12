//
//  ForumViewController.swift
//  EnginnerApp
//
//  Created by majkel on 25.12.2017.
//  Copyright © 2017 majkel. All rights reserved.
//
import SwiftQRCode
import UIKit
import BSQRCodeReader
import QRCode
class ForumViewController: UIViewController,BSQRCodeReaderDelegate,UITableViewDelegate,UITableViewDataSource  {
var refresher : UIRefreshControl!
    @IBOutlet var QrView: BSQRCodeReader!
     @IBOutlet var QRReader: BSQRCodeReader!
    func didCaptureQRCodeWithContent(_ content: String) -> Bool {
      //
        return true
    }

    @IBOutlet var SubsView: UIView!
    
    @IBOutlet var EventView: UIView!
    
    @IBOutlet var CirclesView: UIView!
    
    @IBOutlet var NewsView: UIView!
    var temp = ""
    @IBAction func qrClick(_ sender: Any) {
    
            animateIn(f: "QRView")
        animateIn(f: "EventView")
        
        animateOut(f: "NewsView")
        animateOut(f: "CirclesView")
        animateOut(f: "ProfilView")
        animateOut(f: "EventView")
    }
    
  
      
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var dessTextView: UITextView!
    @IBOutlet weak var descText: UITextField!
    
    var idC : Int?
    @IBAction func addTopicClick(_ sender: Any) {
  
        let str = nameText.text! as String
        let str2 = dessTextView.text! as String
        if str2.characters.count < 140 {
        if str.characters.count > 4 && str2.characters.count > 5{
            addCircle(name: str,description: str2){ circles in
                
                
                self.circles =   circles + self.circles
                self.idC = circles[0].idCircle
                self.id = self.idC!
                self.performSegue(withIdentifier: "TopicSegue", sender: self)
                self.CirclesTableView.reloadData()
               
                //self.addTopicView.isHidden = true
                
            }
            }
            self.addCircleView.isHidden = true
            self.showAddClick.isHidden = false
            self.searchButton.isHidden = false
            
            
        }

        
        
        
    }
    @IBOutlet weak var addCircleView: UIView!
    
    @IBAction func showAddClick(_ sender: Any) {
        addCircleView.isHidden = false
    showAddClick.isHidden = true
         self.searchButton.isHidden = true
    }
    
    
    @IBAction func dissableAdd(_ sender: Any) {
        addCircleView.isHidden = true
        showAddClick.isHidden = false
         self.searchButton.isHidden = false
    }
    
    @IBOutlet weak var showAddClick: UIButton!
    
    @IBOutlet weak var subClick: UIButton!
    
    @IBAction func circleClick(_ sender: Any) {
  
        if(temp != ""){
            animateOut(f: temp)
        }
        if(temp != "CirclesView"){ temp = "CirclesView"
            animateIn(f: "CirclesView")
        }

   
    }
   // @IBAction func subClick(_ sender: Any) {    }
    
   // @IBOutlet weak var subClick: UIButton!
    
    @IBAction func subClick(_ sender: Any) {
        performSegue(withIdentifier: "subSegue", sender: self)
     
    }
    

 
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var addButton: UIButton!
    func animateIn(f:String){
        switch(f){
        case "QRView": self.QrView.isHidden = false
        scan.startScan()
            
        case "NewsView":
            self.NewsTableView.isHidden = false
            
        case "EventView":
            self.EventView.isHidden = false
            
            
        case "CirclesView":            self.CirclesTableView.isHidden = false
            searchButton.isHidden = false
            addButton.isHidden = false
            
        case "SubsView": self.view.addSubview(SubsView)
        self.SubsView.center = self.view.center
        self.SubsView.transform = CGAffineTransform.init(scaleX:20.3,y:1.3)
        self.SubsView.alpha = 0
        UIView.animate(withDuration: 0.4, animations: {
            self.SubsView.alpha = 1
            self.SubsView.transform = CGAffineTransform.identity
        })
       case "ProfilView": self.ProfilImage.isHidden = false
        default:print("")
        }
    }
    
    
    func animateOut(f:String){
        
        
        
        switch(f){
        case "QRView": self.QrView.isHidden = true
       scan.startScan()
            
            
            
        case "SubsView": UIView.animate(withDuration: 0.4, animations: {
            self.SubsView.alpha = 0
            self.SubsView.transform = CGAffineTransform.init(scaleX:2.3,y:1.3)
        }){(success:Bool) in
            self.SubsView.removeFromSuperview()
            }
            
            
            
        case "EventView":
            self.EventView.isHidden = true
            
            
        case "CirclesView":
        self.CirclesTableView.isHidden = true
        searchButton.isHidden = true
        addButton.isHidden = true
            
            
        case "NewsView": self.NewsTableView.isHidden = true
            
        case "ProfilView": self.ProfilImage.isHidden = true
        
        default : print("")
        
        }
    }
    var circles : [CircleModel] = [CircleModel]()
    var news : [MotdModel] = [MotdModel]()
    var events : [EventModel] = [EventModel]()
    var subs : [CircleModel] = [CircleModel]()
    var user = [UserModel]()
    let scan = QRCode()
    override func viewDidLoad() {
        super.viewDidLoad()
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Przeciagnij by odswiezyc")
        refresher.addTarget(self, action: #selector(ForumViewController.populate), for: UIControlEvents.valueChanged)
       
        
        
        scan.prepareScan(QrView, completion: {
            (s)->() in
            var str = s.substring(from: s.index(s.startIndex, offsetBy: 7))
            let str2 = str.substring(to: str.index(str.startIndex, offsetBy: 5))
            if str2 == "Topic" {
            str = s.substring(from: s.index(s.startIndex, offsetBy: 17))
                self.topic = "answer"
                self.id = Int(str)!
                self.performSegue(withIdentifier: "qrTopicSegue", sender: self)

            }
            else {
            str = s.substring(from: s.index(s.startIndex, offsetBy: 18))
                self.topic = "topic"
                self.id = Int(str)!
                self.performSegue(withIdentifier: "TopicSegue", sender: self)
                
            }
            
        })
        scan.scanFrame = view.bounds
        
        
    NewsTableView.delegate = self
        NewsTableView.dataSource = self
       
        circleLimit(howMany: "10", date: Date())
       { circles in
            
           DispatchQueue.main.async {
              self.circles = circles
               self.CirclesTableView.reloadData()
            //self.animateIn(f: "CirclesView")
            }
       }
           motd()  { circles in
        
              DispatchQueue.main.async {
                  self.news = circles
                   self.NewsTableView.reloadData()
              }
        }
          //    eventsTab() { circles in
                   
          //         DispatchQueue.main.async {
         //              self.events = circles
         //           self.EventTableView.reloadData()
         //           }
     //   }
        
       subCircleList() { circles in
            
           DispatchQueue.main.async {
               self.subs = circles
               self.SubsTableView.reloadData()
            }
    
        
        }

        

        
        CirclesTableView.addSubview(refresher)
        CirclesTableView.estimatedRowHeight = 44.0
        CirclesTableView.rowHeight = UITableViewAutomaticDimension
        CirclesTableView.delegate = self
        CirclesTableView.dataSource = self
        
        //NewsTableView.estimatedRowHeight = 44.0
        //NewsTableView.rowHeight = UITableViewAutomaticDimension
        
        EventTableView.delegate = self
        EventTableView.dataSource = self
    
        SubsTableView.delegate = self
        SubsTableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func MotdClick(_ sender: Any) {
       animateIn(f: "NewsView")
        animateOut(f: "CirclesView")
         animateOut(f: "ProfilView")
        animateOut(f: "EventView")
    }
    
    @IBOutlet weak var ForumClick: UIButton!
    
    @IBAction func ForumClick(_ sender: Any) {
        animateOut(f: "NewsView")
        animateIn(f: "CirclesView")
        animateOut(f: "ProfilView")
        animateOut(f: "EventView")
    }
    
    @IBOutlet weak var nameUser: UILabel!
    @IBAction func profilClick(_ sender: Any) {
        animateOut(f: "NewsView")
        animateOut(f: "CirclesView")
        animateIn(f: "ProfilView")
        animateOut(f: "EventView")
        
        nameUser.text = user[0].lastName + " " + user[0].name
        
        var encoded  = user[0].avatar as String
        if encoded.characters.count > 1 {
            if encoded.characters.count > 100 {
                let ind = encoded.startIndex
                encoded = encoded[encoded.index(ind,offsetBy: 22) ..< encoded.endIndex ]
                
                if let imageData = Data(base64Encoded: encoded , options: .ignoreUnknownCharacters){
                    let image = UIImage(data : imageData as Data)
                    ProfilImageView.image = image
                    
                }
            }
            else {
                let  url = URL(string: encoded)
                
                let data = try? Data(contentsOf: url!)
                ProfilImageView.image = UIImage(data: data!)
            }
        }
        ProfilImageView.layer.cornerRadius = ProfilImageView.frame.size.width / 3
       ProfilImageView.clipsToBounds = true
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var NewsTableView: UITableView!
 
    @IBOutlet weak var CirclesTableView: UITableView!

    @IBOutlet weak var EventTableView: UITableView!
    @IBOutlet weak var SubsTableView: UITableView!

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.CirclesTableView  {return (circles.count)//CircleDict.count
        }
    if tableView == self.EventTableView  {return (events.count)//EventDict.count
        }
        if tableView == self.NewsTableView  {return (news.count)//NewsDict.count
        }
        if tableView == self.SubsTableView  {return (subs.count)//SubDict.count
        }
        else {return 2}
    }
    @IBOutlet weak var qrGenerated: UIImageView!
    @IBOutlet weak var qrGeneratedView: UIView!
    
    @IBAction func dissQR(_ sender: Any) {
         qrGeneratedView.isHidden = true
    }
    
    func shareButton(sender: UIButton){
    let index = sender.tag
     let qrCode = QRCode("DMTAPP;Circle;Red;\(index)")
    qrGenerated.image = qrCode?.image
    qrGeneratedView.isHidden = false
    }
    
    
    @IBOutlet weak var eventClick: UIButton!
    
    @IBAction func eventClick(_ sender: Any) {
        performSegue(withIdentifier: "eventSegue", sender: self)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CustomCell
      cell.selectionStyle = .none
        
        
        if tableView == self.CirclesTableView {
        cell.AuthorLabelCircle.text = circles[indexPath.item].author.lastName
        cell.circleShareW.tag = indexPath.item
            cell.circleShareW.addTarget(self, action: #selector(ForumViewController.shareButton), for: .touchUpInside)
            
            cell.ContentLabelCircle.text = circles[indexPath.item].description
      
            var encoded  = circles[indexPath.item].author.avatar as String
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
               cell.ImageViewCircle.layer.cornerRadius = cell.ImageViewCircle.frame.size.width / 2
                cell.ImageViewCircle.clipsToBounds = true
            
            
            cell.NameLabelCircle.text = circles[indexPath.item].name
           
            cell.NumberFollowerLabelCircle.text = String(describing:circles[indexPath.item].countSubbed)
            cell.NumberTopicsLabelCircle.text = String(describing:circles[indexPath.item].countTopic)

            let date = String(describing: (circles[indexPath.item].publishDate))
            let str = date.substring(to: date.index(date.startIndex, offsetBy: 11))
            cell.DateLabelCircle.text = str
            
            cell.ContentLabelCircle.sizeToFit()
            cell.ContentLabelCircle.layoutIfNeeded()
            cell.NameLabelCircle.sizeToFit()
             cell.NameLabelCircle.layoutIfNeeded()
        cell.cardViewCircle()
        }
        
        if tableView == self.EventTableView {
          cell.AuthorLabelEvent.text = "b"//events?[indexPath.item].data
      //    var encoded  = events?[indexPath.item].author.avatar as String
            
        //    if encoded.characters.count > 100 {
        //        let ind = encoded.startIndex
        //        encoded = encoded[encoded.index(ind,offsetBy: 22) ..< encoded.endIndex ]
                
        //        if let imageData = Data(base64Encoded: encoded , options: .ignoreUnknownCharacters){
        //            let image = UIImage(data : imageData as Data)
        //            cell.ImageViewEvent.image = image
                    
       //         }
      //      }
      //      else {
       //         let  url = URL(string: encoded)
                
      //          let data = try? Data(contentsOf: url!)
      //          cell.ImageViewEvent.image = UIImage(data: data!)
          //  }
      //      cell.ImageViewEvent.layer.cornerRadius = cell.ImageViewCircle.frame.size.width / 2
      //      cell.ImageViewEvent.clipsToBounds = true

            cell.ContentLabelEvent.text = "b"
            cell.DateLabelEvent.text = "b"
            cell.NumberTopicEvent.text = "b"
            cell.NumberFollowerEvent.text = "b"
            cell.cardViewEvent()
        }
        
        
        if tableView == self.NewsTableView {
            if (news[indexPath.item].author.lastName.characters.count) > 1 || (news[indexPath.item].author.name.characters.count) > 1{ cell.AuthorLabelNews.text = (news[indexPath.item].author.lastName) + " " + (news[indexPath.item].author.name) }
            cell.AuthorLabelNews.sizeToFit()
            cell.DateLabelNews.sizeToFit()
            cell.DateLabelNews.text = ""//news[indexPath.item].timestamp
            var encoded  = (news[indexPath.item].author.avatar) as String
            if encoded.characters.count > 1 {
            if encoded.characters.count > 100 {
                let ind = encoded.startIndex
                encoded = encoded[encoded.index(ind,offsetBy: 22) ..< encoded.endIndex ]
                
                if let imageData = Data(base64Encoded: encoded , options: .ignoreUnknownCharacters){
                    let image = UIImage(data : imageData as Data)
                    cell.imageViewNews.image = image
                    
                }
            }
            else {
                let  url = URL(string: encoded)
                
                let data = try? Data(contentsOf: url!)
                cell.imageViewNews.image = UIImage(data: data!)
            }
                }
            cell.imageViewNews.layer.cornerRadius = cell.imageViewNews.frame.size.width / 2
            cell.imageViewNews.clipsToBounds = true

            cell.ContentLabelNews.sizeToFit()
            
            cell.ContentLabelNews.text = news[indexPath.item].message
             cell.ContentLabelNews.sizeToFit()
            cell.ContentLabelNews.layoutIfNeeded()
        }
        //  {
        //if tableView == self.NewsTableView{}
       // if tableView == self.SubsTableView {}
       // 
        
        if tableView == self.CirclesTableView{
            if self.circles.count > 8 {
        if indexPath.row == self.circles.count - 1
        {
            populated()
            }
    }
            }
        
       // if tableView == self.EventTableView {}
        //    populated()
        // }
      
        
        
        return cell
        
    }
    @IBOutlet weak var profilClick: UIButton!
    @IBAction func profilClicks(_ sender: Any) {
        
        animateIn(f: "ProfilView")
        
    }
    func populate(){
        
        //circles =
        
        circleLimit(howMany: "10", date: Date())
        { circles in
            
            DispatchQueue.main.async {
                self.circles = circles
                self.CirclesTableView.reloadData()
                //self.animateIn(f: "CirclesView")
            }
        }
         refresher.endRefreshing()

    }
    func populated(){
        
        circleLimit(howMany: "10", date: circles[circles.count-1].publishDate, completion: { circles in
            
            DispatchQueue.main.async {
                self.circles.append(contentsOf:  circles)
                self.CirclesTableView.reloadData()
                //self.animateIn(f: "CirclesView")
            }
        }
            
        )
      
   //     tableView.reloadData()
    }
    var row = "  "
    var topic = ""
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
           // let e = ExampleMessengerViewController()
           // e.bootstrapWithRandomMessages = 6
          //  navigationController?.pushViewController(e, animated: true)
         //   present(e,animated:true,completion:nil)
            
            if tableView == self.CirclesTableView {
                row = circles[indexPath.item].name
                id = circles[indexPath.item].idCircle
                isSubC = circles[indexPath.item].isSubbed
                topic = "topic"
            performSegue(withIdentifier: "TopicSegue", sender: self)
            }
        
        //else{
  //          row = tematy[indexPath.row]
  //          przejscie = true
          //. performSegue(withIdentifier: "pokazTematSeque", sender: self)
        }
var id = 1
    var rowT = ""
    var isSubC = 1
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if topic == "topic"  { let dest: TopicViewController = segue.destination as! TopicViewController
            dest.idCircle = id
            dest.nameCircle = rowT
        dest.isSubC = isSubC
            }
     
        if topic == "search" {
            let dest: SearchViewController = segue.destination as! SearchViewController
           
            dest.thinkToSearch = "circle"
        
        
        }
        if topic == "answer" {
            let dest: AnswerViewController = segue.destination as! AnswerViewController
            
            dest.idTopic = id
            
            
        }
           topic = ""
        }
    
    @IBOutlet weak var ProfilImageView: UIImageView!
    
    @IBOutlet weak var ProfilView: UIView!
    @IBOutlet weak var ProfilImage: UIView!
    
    @IBAction func logoutClick(_ sender: Any) {
        
        deleteLD()
        performSegue(withIdentifier: "logoutSegue", sender: self)
    }
    @IBOutlet weak var logoutClick: UIButton!
    @IBAction func InfoClick(_ sender: Any) {
        
    }
    
    @IBAction func searchClick(_ sender: Any) {
    
        
        topic = "search"
        performSegue(withIdentifier: "searchCircleSegue", sender: self)
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


