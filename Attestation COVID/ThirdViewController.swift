//
//  ThirdViewController.swift
//  Attestation COVID
//
//  Created by Hervé Kasparian on 11/04/2020.
//  Copyright © 2020 Hervé Kasparian. All rights reserved.
//


import UIKit




class ThirdViewController: UIViewController, UITextFieldDelegate {

    var firstAppear:Bool=true
    @IBOutlet var PrenomTextField: UITextField!
    @IBOutlet var NomTextField: UITextField!
    
    @IBOutlet var AdresseTextField: UITextField!
    
    @IBOutlet var CPTextField: UITextField!
    @IBOutlet var VilleTextField: UITextField!
    
    @IBOutlet var LieuDNTextField: UITextField!
    
    @IBOutlet var DatePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        PrenomTextField.text=Prenom
        NomTextField.text=Nom
        AdresseTextField.text=Adresse
        CPTextField.text=CP
        VilleTextField.text=Ville
        LieuDNTextField.text=LieuDN
        DatePicker.date=DDN
        PrenomTextField.delegate=self
        NomTextField.delegate=self
        AdresseTextField.delegate=self
        CPTextField.delegate=self
        VilleTextField.delegate=self
        LieuDNTextField.delegate=self
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
              let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let scrollup = UISwipeGestureRecognizer(target: self, action: #selector(handleScroll(_:)))
         let scrolldown = UISwipeGestureRecognizer(target: self, action: #selector(handleScroll(_:)))
        scrollup.direction = .up
        scrolldown.direction = .down
              leftSwipe.direction = .left
              rightSwipe.direction = .right
              self.view.addGestureRecognizer(leftSwipe)
              self.view.addGestureRecognizer(rightSwipe)
            self.view.addGestureRecognizer(scrollup)
            self.view.addGestureRecognizer(scrolldown)
        
       }
       @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
           if sender.direction == .left {
               self.tabBarController!.selectedIndex = 0
           }
           if sender.direction == .right {
               self.tabBarController!.selectedIndex = 1
           }
       }
 @objc func handleScroll(_ sender:UISwipeGestureRecognizer) {
              if sender.direction == .down {
                 HideKB()
              }
              if sender.direction == .up {
                  HideKB()
              }
          }
    override func viewWillDisappear(_ animated: Bool) {
        Prenom=PrenomTextField.text!
        Nom=NomTextField.text!
        Adresse=AdresseTextField.text!
        CP=CPTextField.text!
        Ville=VilleTextField.text!
        LieuDN=LieuDNTextField.text!
        DDN=DatePicker.date
        UserDefaults.standard.set(Prenom,forKey: "prenom")
               UserDefaults.standard.set(Nom,forKey: "nom")
               UserDefaults.standard.set(Adresse,forKey: "adresse")
               UserDefaults.standard.set(CP,forKey: "CP")
               UserDefaults.standard.set(Ville,forKey: "ville")
               UserDefaults.standard.set(LieuDN,forKey: "lieuDN")
               UserDefaults.standard.set(DDN,forKey: "DDN")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        PrenomTextField.becomeFirstResponder()
        if !firstAppear{ MarqueEnRouge()}else{firstAppear=false}
    }
    
    @IBAction func Nomdidfinish(_ sender: Any) {
       // NomTextField.becomeFirstResponder()
    }
    @IBAction func Prenomdidfinish(_ sender: Any) {
       // AdresseTextField.becomeFirstResponder()
    }
    @IBAction func Adressedidfinish(_ sender: Any) {
      //  CPTextField.becomeFirstResponder()
    }
    @IBAction func CPdidfinish(_ sender: Any) {
       // VilleTextField.becomeFirstResponder()
    }
    @IBAction func Villedidfinish(_ sender: Any) {
      //  LieuDNTextField.becomeFirstResponder()
    }
    @IBAction func Lieudidfinish(_ sender: Any) {
       // LieuDNTextField.resignFirstResponder()
    }
    var MytextField:UITextField?
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        MytextField=textField
        _=Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(RetardMarqueRouge), userInfo: nil, repeats: false)
        if !isHiding {switch textField{
            case PrenomTextField :NomTextField.becomeFirstResponder()
            case NomTextField :AdresseTextField.becomeFirstResponder()
            case AdresseTextField :CPTextField.becomeFirstResponder()
            case CPTextField :VilleTextField.becomeFirstResponder()
            case VilleTextField :LieuDNTextField.becomeFirstResponder()
            default :textField.resignFirstResponder()
            }}
        return false
    }
    @objc func RetardMarqueRouge(){
        
            MytextField?.MarqueEnRougeouPas()
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.backgroundColor = .clear
        return true
    }

    @IBAction func DateDidChange(_ sender: Any) {
       print("aa")
         HideKB()
        if DatePicker.date.timeIntervalSinceNow > -100000000 {
            DatePicker.backgroundColor = .orange
        }else{
            DatePicker.backgroundColor = .clear
        }
    }
    @objc func HideVraiment(){
        LieuDNTextField.resignFirstResponder()
        isHiding=false
    }
    var timer=Timer()
    var isHiding:Bool=false
    func HideKB(){
        isHiding=true
        UIView.setAnimationsEnabled(false)

                LieuDNTextField.becomeFirstResponder()
                LieuDNTextField.resignFirstResponder()
       
             timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(HideVraiment), userInfo: nil, repeats: false)
        
        UIView.setAnimationsEnabled(true)

           
        
    }
    @IBAction func KBH(_ sender: Any) {HideKB()
    }
    
    @IBAction func KBH2(_ sender: Any) {HideKB()
    }
    @IBAction func BackDidTouch(_ sender: Any) {
        HideKB()
       // self.tabBarController?.selectedIndex =  0
        
    }
    func MarqueEnRouge(){
        PrenomTextField.MarqueEnRougeouPas()
            
        NomTextField.MarqueEnRougeouPas()
        AdresseTextField.MarqueEnRougeouPas()
        CPTextField.MarqueEnRougeouPas()
        VilleTextField.MarqueEnRougeouPas()
        LieuDNTextField.MarqueEnRougeouPas()
        if DatePicker.date.timeIntervalSinceNow > -100000000 {
            DatePicker.backgroundColor = .orange
        }else{
            DatePicker.backgroundColor = .clear
        }
    }
}


        

extension UITextField{
    func MarqueEnRougeouPas(){
        if self.text==""{
            self.backgroundColor=UIColor.orange
        }else{
            self.backgroundColor = .clear
        }
        
    }
}
