//
//  LoginViewController.swift
//  EnginnerApp
//
//  Created by majkel on 25.12.2017.
//  Copyright © 2017 majkel. All rights reserved.
//

import UIKit
import BSQRCodeReader
import QRCodeController
import SwiftQRCode

class LoginViewController: UIViewController,BSQRCodeReaderDelegate{
    @IBOutlet var StatueView: UIView!
    

    @IBOutlet var PinView: UIView!
   
   // @IBOutlet var QrView: BSQRCodeReader!
    @IBOutlet weak var QRReader: BSQRCodeReader!
    @IBOutlet weak var QrView: UIView!
    let qrcodeScanner = QRCodeController()

    func animateIn(f:String){
        switch(f){
        case "QRView":
            self.animateOut(f: "StatueView")
            QrView.isHidden = false
            
            scan.startScan()
            
            
            
        case "StatueView": self.view.addSubview(StatueView)
        self.StatueView.center = self.view.center
        self.StatueView.transform = CGAffineTransform.init(scaleX:1.3,y:1.3)
        self.StatueView.alpha = 0
        UIView.animate(withDuration: 0.4, animations: {
            self.StatueView.alpha = 1
            self.StatueView.transform = CGAffineTransform.identity
        })
            
        case "PinView": self.view.addSubview(PinView)
        QRReader.isHidden = true
        self.PinView.center = self.view.center
        self.PinView.transform = CGAffineTransform.init(scaleX:1.3,y:1.3)
        self.PinView.alpha = 0
        UIView.animate(withDuration: 0.4, animations: {
            self.PinView.alpha = 1
            self.PinView.transform = CGAffineTransform.identity
        })
        default:print("")
        }
    }
    
    func animateOut(f:String){
        
        
        
        switch(f){
        case "QRView": self.QRReader.isHidden = true
        self.QRReader.stopScanning()
            
            
            
        case "StatueView": UIView.animate(withDuration: 0.4, animations: {
            self.StatueView.alpha = 0
            self.StatueView.transform = CGAffineTransform.init(scaleX:1.3,y:1.3)
        }){(success:Bool) in
            self.StatueView.removeFromSuperview()
            }
            
        case "PinView": UIView.animate(withDuration: 0.4, animations: {
            self.PinView.alpha = 0
            
            self.PinView.transform = CGAffineTransform.init(scaleX:1.3,y:1.3)
        }){(success:Bool) in
            self.PinView.removeFromSuperview()
            }
        default:print("")
            
            
        }
    }
    @IBOutlet weak var pinValue: UITextField!
    
    @IBAction func agreeClick(_ sender: Any) {
        animateOut(f: "StatueView")
        animateIn(f: "QRView")
    }
    
    @IBOutlet weak var infoLabel: UILabel!
      var user = [UserModel]()
    var i = 0
    @IBAction func PinClick(_ sender: Any) {
      
           if !checkLD() {
        savePass(pass: pinValue.text!)
              saveLD(token: token)
        validatePin(token: loadLD(),pin: loadPass()){ v in
            DispatchQueue.main.async {
                self.user = v
                self.performSegue(withIdentifier: "loginSegue", sender: self)
            }
            }
           }
               else {
                    if pinValue.text! != loadPass() {
                   pinValue.text = ""
                       infoLabel.sizeToFit()
                   infoLabel.text = "Jesli nie pamietasz haslo , wejdz na wersje webowa aplikacji"
                } else {
            validatePin(token: loadLD(),pin: loadPass()){ v in
                DispatchQueue.main.async {
                    self.user = v
                    self.performSegue(withIdentifier: "loginSegue", sender: self)
                }
            }
           }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest: ForumViewController = segue.destination as! ForumViewController
        dest.user = user
    }
    
    
var token : String = ""
 
     
    var check = false
    let scan = QRCode()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.QRReader.isHidden = true
self.pinValue.becomeFirstResponder()
       
        scan.prepareScan(QrView, completion: {
        (s)->() in
           saveLD(token: s)
            self.token = s
            self.scan.stopScan()
            self.animateIn(f: "PinView")
        
        })
        scan.scanFrame = view.bounds

        //self.QRReader.delegate = self
        if(!checkLD()){
            animateIn(f: "StatueView")
            check = true
        }
        else
        {
            check = false
            animateIn(f: "PinView")
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: BSQRCodeReaderDelegate
    func didFailWithError(_ error: NSError) {
        
    }
    func beforeStartScanning(_ reader: BSQRCodeReader){
        
    }
    func afterStopScanning(_ reader: BSQRCodeReader){
        
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
