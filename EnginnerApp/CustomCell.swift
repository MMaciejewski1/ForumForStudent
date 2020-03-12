//
//  CustomCell.swift
//  EnginnerApp
//
//  Created by majkel on 26.12.2017.
//  Copyright © 2017 majkel. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
//news
    @IBOutlet weak var imageViewNews: UIImageView!
    
    @IBOutlet weak var AuthorLabelNews: UILabel!
    
    @IBOutlet weak var ContentLabelNews: UILabel!
    
    @IBOutlet weak var DateLabelNews: UILabel!
//circle
    @IBOutlet weak var ImageViewCircle: UIImageView!
    
    @IBOutlet weak var circleShareW: UIButton!
    @IBOutlet weak var DateLabelCircle: UILabel!
    @IBOutlet weak var NameLabelCircle: UILabel!
    @IBOutlet weak var AuthorLabelCircle: UILabel!
    
    @IBOutlet weak var ContentLabelCircle: UILabel!
    @IBOutlet weak var NumberTopicsLabelCircle: UILabel!
    @IBOutlet weak var NumberFollowerLabelCircle: UILabel!
    
//subs

    @IBOutlet weak var ImageViewSub: UIImageView!
    
    @IBOutlet weak var AuthorLabelSub: UILabel!
   
    @IBOutlet weak var DateLabelSub: UILabel!
    
    @IBOutlet weak var ContentLabelSub: UILabel!
  
    @IBOutlet weak var NumberFollowerSub: UILabel!
    
    @IBOutlet weak var NumberTopicSub: UILabel!
 
    @IBOutlet weak var NameLabelSub: UILabel!
    //event
    
    @IBOutlet weak var ImageViewEvent: UIImageView!
    
   // @IBOutlet weak var AuthorLabelEvent: UILabel!
    
    @IBOutlet weak var DateLabelEvent: UILabel!
    @IBOutlet weak var AuthorLabelEvent: UILabel!
    //@IBOutlet weak var AuthorLabelEvent: UILabel!
    
    @IBOutlet weak var ContentLabelEvent: UILabel!
    
    @IBOutlet weak var NumberFollowerEvent: UILabel!
    @IBOutlet weak var NumberTopicEvent: UILabel!
    
    //topic
    @IBOutlet weak var imageTopic: UIImageView!
    
    @IBOutlet weak var authorTopic: UILabel!
    
    @IBOutlet weak var topicShareW: UIButton!
    @IBOutlet weak var nameTopic: UILabel!
    
    @IBOutlet weak var dateTopic: UILabel!
   
    @IBOutlet weak var contentTopic: UILabel!
    
    @IBOutlet weak var countAnswTopic: UILabel!
    
    @IBOutlet weak var CountSubTopic: UILabel!
    
    @IBOutlet weak var backgroundCircleView: UIView!
    
    @IBOutlet weak var backgroundEventView: UIView!
    
    @IBOutlet weak var backgroundSubView: UIView!
    
    @IBOutlet weak var backgroundTopicView: UIView!
   
    //answer 
    
    @IBOutlet weak var dateAnswer: UILabel!
    
    @IBOutlet weak var authorAnswer: UILabel!
    
    @IBOutlet weak var contentAnswer: UILabel!
    
    @IBOutlet weak var backgroundAnswerView: UIView!
    
    @IBOutlet weak var imageAnswer: UIImageView!
    
    
    
    /// circle sub 
    @IBOutlet weak var circleShareSub: UIButton!
    
    @IBOutlet weak var authorCircleSub: UILabel!
    @IBOutlet weak var dateCircleSub: UILabel!
    
    @IBOutlet weak var contentCircleSub: UILabel!
    
    @IBOutlet weak var topicCircleSub: UILabel!
    
    @IBOutlet weak var subCircleSub: UILabel!
    @IBOutlet weak var backgroundCircleSub: UIView!
    
    @IBOutlet weak var imageCircleSub: UIImageView!
    
    
    @IBOutlet weak var circleShare: UIButton!
    //topic sub
    
    @IBOutlet weak var topicShare: UIButton!
    @IBOutlet weak var authorTopicSub: UILabel!
    
    @IBOutlet weak var dateTopicSub: UILabel!
    
    @IBOutlet weak var nameTopicSub: UILabel!
    
    @IBOutlet weak var contentTopicSub: UILabel!
    
    @IBOutlet weak var answerTopicSub: UILabel!
    
    @IBOutlet weak var subTopicSub: UILabel!
    
    @IBOutlet weak var backgroundTopicSub: UIView!
 
    @IBOutlet weak var imageTopicSub: UIImageView!
    
    //circle search
    
    @IBOutlet weak var circleSearchShare: UIButton!
    
    
    //topic search
    
    @IBOutlet weak var topicSearchShare: UIButton!
    
    
    //events
    
    @IBOutlet weak var imageEvent: UIImageView!
    
    @IBOutlet weak var contentEvent: UILabel!
   // @IBOutlet weak var imageEvent: UILabel!
    
    @IBOutlet weak var dateEvent: UILabel!
    
    
    
    func cardViewTopicSubView(){
        backgroundTopicSub.backgroundColor = UIColor.white
        backgroundTopicSub.layer.cornerRadius = 3.0
        backgroundTopicSub.layer.masksToBounds = false
        backgroundTopicSub.layer.shadowColor = UIColor.black.cgColor
        backgroundTopicSub.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundTopicSub.layer.shadowOpacity = 0.8
    }
    func cardViewCircleSub(){
        backgroundCircleSub.backgroundColor = UIColor.white
        backgroundCircleSub.layer.cornerRadius = 3.0
        backgroundCircleSub.layer.masksToBounds = false
        backgroundCircleSub.layer.shadowColor = UIColor.black.cgColor
        backgroundCircleSub.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundCircleSub.layer.shadowOpacity = 0.8
    }
    
    func cardViewEvent(){
        backgroundEventView.backgroundColor = UIColor.white
        backgroundEventView.layer.cornerRadius = 3.0
        backgroundEventView.layer.masksToBounds = false
        backgroundEventView.layer.shadowColor = UIColor.black.cgColor
        backgroundEventView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundEventView.layer.shadowOpacity = 0.8
    }
    
    func cardViewAnswer(){
        backgroundAnswerView.backgroundColor = UIColor.white
        backgroundAnswerView.layer.cornerRadius = 3.0
        backgroundAnswerView.layer.masksToBounds = false
        backgroundAnswerView.layer.shadowColor = UIColor.black.cgColor
        backgroundAnswerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundAnswerView.layer.shadowOpacity = 0.8
    }

    func cardViewTopic(){
        backgroundTopicView.backgroundColor = UIColor.white
        backgroundTopicView.layer.cornerRadius = 3.0
        backgroundTopicView.layer.masksToBounds = false
        backgroundTopicView.layer.shadowColor = UIColor.black.cgColor
        backgroundTopicView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundTopicView.layer.shadowOpacity = 0.8
    }

    
    func cardViewSub(){
        backgroundSubView.backgroundColor = UIColor.white
        backgroundSubView.layer.cornerRadius = 3.0
        backgroundSubView.layer.masksToBounds = false
        backgroundSubView.layer.shadowColor = UIColor.black.cgColor
        backgroundSubView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundSubView.layer.shadowOpacity = 0.8
    }
    func cardViewCircle(){
        backgroundCircleView.backgroundColor = UIColor.white
        backgroundCircleView.layer.cornerRadius = 3.0
        backgroundCircleView.layer.masksToBounds = false
        backgroundCircleView.layer.shadowColor = UIColor.black.cgColor
        backgroundCircleView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundCircleView.layer.shadowOpacity = 0.8
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
        
        
       
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
