//
//  AnswerViewController.swift
//  EnginnerApp
//
//  Created by majkel on 08.01.2018.
//  Copyright © 2018 majkel. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController,UITableViewDelegate ,UITableViewDataSource    {

    @IBOutlet weak var answerTableView: UITableView!
    var answ : Array<AnswerModel> = Array<AnswerModel>()
    var idTopic: Int?
    var nameTopic : String?
    var isSub: Int?
    var refresher : UIRefreshControl!
    var content = ""
    func tap(sender:UITapGestureRecognizer){
    if (content.characters.count) > 33
    {
        content = (nameTopic?.substring(to: (nameTopic?.index((nameTopic?
            .startIndex)!, offsetBy: 29))!))! + "..."
       
        
        
    }
        else
    {
        content = nameTopic!
        
        }
         contentLabel.text = content
        contentLabel.sizeToFit()
        contentLabel.layoutIfNeeded()
    }
    
    @IBOutlet weak var contentLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        content = nameTopic!
        contentLabel.text = content
        
        contentLabel.layer.masksToBounds = true
        contentLabel.numberOfLines = 0
        
        contentLabel.sizeToFit()
        contentLabel.layoutIfNeeded()
        let t = UITapGestureRecognizer(target:self,action: #selector(AnswerViewController.tap))
        contentLabel.addGestureRecognizer(t)
        contentLabel.isUserInteractionEnabled = true
        answerTableView.estimatedRowHeight = 44.0
        answerTableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
        answerLimit(howMany: "10", id: idTopic!,date: Date())
        { circles in
            
            DispatchQueue.main.async {
                self.answ = circles
                self.answerTableView.reloadData()
               
            }
            
           

        }
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Przeciagnij by odswiezyc")
        refresher.addTarget(self, action: #selector(TopicViewController.populate), for: UIControlEvents.valueChanged)
        answerTableView.addSubview(refresher)
        if(isSub == 0)
        {  subImage.setImage(images[1], for: UIControlState.normal) }
       else { subImage.setImage(images[0], for: UIControlState.normal)}
        
        answerTableView.dataSource = self
        answerTableView.delegate = self
   
    
    
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (answ.count)
    }
    
    var images = [#imageLiteral(resourceName: "star.png"),#imageLiteral(resourceName: "star1600.png")]
    
    @IBOutlet weak var subImage: UIButton!

    @IBAction func subClick(_ sender: Any) {
    
        if(isSub == 0)
        {
            isSub = 1
             subImage.setImage(images[0], for: UIControlState.normal)
            subTopic(id: idTopic!, status: true)
           
        }
        else
        {
        isSub = 0
            subImage.setImage(images[1], for: UIControlState.normal)
            subTopic(id:idTopic!, status: false)
        
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CustomCell
        let datef = DateFormatter()
        datef.dateFormat = "yyyy-mm-dd hh:mm"
        cell.selectionStyle = .none
        cell.cardViewAnswer()
        cell.dateAnswer.text = datef.string(for: answ[indexPath.item].publishDate as Date)
        cell.authorAnswer.text = answ[indexPath.item].author.lastName
        cell.contentAnswer.text = answ[indexPath.item].content
        cell.contentAnswer.sizeToFit()
        cell.contentAnswer.layoutIfNeeded()
     var encoded  = answ[indexPath.item].author.avatar as String
        if encoded.characters.count > 1{
        
        if encoded.characters.count > 100 {
            let ind = encoded.startIndex
            encoded = encoded[encoded.index(ind,offsetBy: 22) ..< encoded.endIndex ]
            
            if let imageData = Data(base64Encoded: encoded , options: .ignoreUnknownCharacters){
                let image = UIImage(data : imageData as Data)
                cell.imageAnswer.image = image
                
            }
        }
        else {
            let  url = URL(string: encoded)
            
            let data = try? Data(contentsOf: url!)
            cell.imageAnswer.image = UIImage(data: data!)
        }
            }
        cell.imageAnswer.layer.cornerRadius = cell.imageAnswer.frame.size.width / 2
        cell.imageAnswer.clipsToBounds = true

        
        
        return cell
    }

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var answerTextField: UITextField!
    
    @IBAction func sendAnswer(_ sender: Any) {
        if (answerTextField.text?.characters.count)! > 3 {
        
        addAnswer(content: answerTextField.text!,id: String(idTopic!))
                { circles in
                    
                    DispatchQueue.main.async {
                        self.answ =  circles + self.answ
                        self.answerTableView.reloadData()
                        
                    }
  
                }
        }
    
    }
    func populated(){
        
         answerLimit(howMany: "10", id:idTopic!,date: answ[answ.count-1].publishDate, completion: { circles in
            
            DispatchQueue.main.async {
                self.answ.append(contentsOf:  circles)
                self.answerTableView.reloadData()
                //self.animateIn(f: "CirclesView")
            }
        }
            
        )
        
    }
    
    func populate(){
        answerLimit(howMany: "10", id:idTopic!,date: Date(), completion: { circles in
            
            DispatchQueue.main.async {
                self.answ.append(contentsOf:  circles)
                self.answerTableView.reloadData()
                //self.animateIn(f: "CirclesView")
            }
            
        }
        )
        refresher.endRefreshing()
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
