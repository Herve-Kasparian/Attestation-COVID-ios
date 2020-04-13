//
//  FirstViewController.swift
//  Attestation COVID
//
//  Created by Hervé Kasparian on 11/04/2020.
//  Copyright © 2020 Hervé Kasparian. All rights reserved.
//

import UIKit
var Prenom:String=""
var Nom:String=""
var Adresse:String=""
var CP:String=""
var Ville:String=""
var LieuDN:String=""
var DDN:Date=Date()
var ConditionAccepted:Bool=false
class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         Prenom=UserDefaults.standard.string(forKey: "prenom") ?? ""
         Nom=UserDefaults.standard.string(forKey: "nom") ?? ""
         Adresse=UserDefaults.standard.string(forKey: "adresse") ?? ""
         CP=UserDefaults.standard.string(forKey: "CP") ?? ""
         Ville=UserDefaults.standard.string(forKey: "ville") ?? ""
         LieuDN=UserDefaults.standard.string(forKey: "lieuDN") ?? ""
         DDN=UserDefaults.standard.object(forKey: "DDN") as? Date ?? Date()
        ConditionAccepted=UserDefaults.standard.bool(forKey: "Accepted")
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        
        if ConditionAccepted{
        
        if Prenom=="" || Nom=="" || Adresse=="" || CP=="" || Ville=="" || LieuDN=="" || DDN.timeIntervalSinceNow > -100000000 {
            self.tabBarController?.selectedIndex =  2
        }
        }else{
            let ConditionAlert = UIAlertController(title: "Conditions d'utilisation", message: "Cette application est là pour vous aider à remplir le formulaire pdf mis à disposition par le ministère de l'intérieur, à jour au 11 avril 2020. \n\nIl est de votre responsabilité de vérifier que les modalités de déplacements dérogatoires n'ont pas évolué depuis cette date.\n\nVous utilisez cette application telle que fournie et restez entièrement responsable de vous acquitter de toutes les obligations qui vous incombent, en particulier en respectant scrupuleusement les règles du confinement, ainsi que les \"gestes barrières\" et la \"distanciation sociale\" recomandés.\n\nVous reconnaissez que le développeur de cette application ne pourra en aucun cas être tenu responsable des conséquences liées à l'utilisation de l'application.\n\nMerci en prendre acte, ou quitter l'application", preferredStyle: .alert)
                ConditionAlert.addAction(UIAlertAction(title: "J'accepte", style: .default, handler: { (action: UIAlertAction) in
                           UserDefaults.standard.set(true, forKey: "Accepted")
                            ConditionAccepted=true
                     self.tabBarController?.selectedIndex =  2

                           }))
               /* ConditionAlert.addAction(UIAlertAction(title: "Non", style: .default, handler: { (action: UIAlertAction) in
                    self.present(ConditionAlert, animated: true, completion: nil)

                }))*/
                                        
                           
                           
                self.present(ConditionAlert, animated: true, completion: nil)
        }
    }
    
    func generateQRCode(from string: String) -> UIImage? {
          let data = string.data(using: String.Encoding.ascii)

          if let filter = CIFilter(name: "CIQRCodeGenerator") {
              filter.setValue(data, forKey: "inputMessage")
              let transform = CGAffineTransform(scaleX: 10, y: 10)

              if let output = filter.outputImage?.transformed(by: transform) {
                  return UIImage(ciImage: output)
              }
          }

          return nil
      }
    /*    const generateQR = async text => {
      try {
        var opts = {
          errorCorrectionLevel: 'M',
          type: 'image/png',
          quality: 0.92,
          margin: 1,
        }
        return await QRCode.toDataURL(text, opts)
      } catch (err) {
        console.error(err)
      }
    }*/
    @IBAction func Bouton1didTouch(_ sender: Any) {editPDF(Motif:0)}
    
    @IBAction func BoutonSport(_ sender: Any) {editPDF(Motif:1)
    }
    @IBAction func BoutonTravail(_ sender: Any) {editPDF(Motif:2)
    }
    
    @IBAction func BoutonSanté(_ sender: Any) {editPDF(Motif:3)
    }
    
    @IBAction func BoutonFamille(_ sender: Any) {editPDF(Motif:4)
    }
    
    @IBAction func BoutonJudiciaire(_ sender: Any) {editPDF(Motif:5)
    }
    
    @IBAction func BoutonMission(_ sender: Any) {editPDF(Motif:6)
    }
    func createPDFFileAndReturnPath() -> String {

        let fileName = "CurrentAttestion.pdf"
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0] as NSString
        let pathForPDF = documentsDirectory.appending("/" + fileName)

        UIGraphicsBeginPDFContextToFile(pathForPDF, CGRect.zero, nil)

        UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: 100, height: 400), nil)

       
        UIGraphicsEndPDFContext()

        return pathForPDF
    }

    func editPDF(Motif:Int) {
        let font20 = UIFont.boldSystemFont(ofSize: 20)
        let font11 = UIFont.systemFont(ofSize: 11)
         let font7 = UIFont.systemFont(ofSize: 7)
        let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
                          paragraphStyle.alignment = NSTextAlignment.left
        paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping

        let textColor = UIColor.black

        let textFontAttributes20 = [
            NSAttributedString.Key.font: font20,
                              NSAttributedString.Key.foregroundColor: textColor,
                              NSAttributedString.Key.paragraphStyle: paragraphStyle
                          ]
       
        let textFontAttributes7 = [
                   NSAttributedString.Key.font: font7,
                                     NSAttributedString.Key.foregroundColor: textColor,
                                     NSAttributedString.Key.paragraphStyle: paragraphStyle]
        let textFontAttributes11 = [
        NSAttributedString.Key.font: font11,
                          NSAttributedString.Key.foregroundColor: textColor,
                          NSAttributedString.Key.paragraphStyle: paragraphStyle]
        
        
        
        let fileName = "CurrentAttestion.pdf"
        
               let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
               let documentsDirectory = paths[0] as NSString
               let pathForPDF = documentsDirectory.appending("/" + fileName)
        
        
        guard UIGraphicsBeginPDFContextToFile(pathForPDF, CGRect.zero, nil) else {
            return
        }
        guard let destContext = UIGraphicsGetCurrentContext() else {
            return
        }
        

        let url = Bundle.main.url(forResource: "Attestation", withExtension: "pdf")! as CFURL
        let originalPDF:CGPDFDocument=CGPDFDocument(url)!
        
        
        if let page = originalPDF.page(at: 1) {
            var mediaBox = page.getBoxRect(.mediaBox)
            destContext.beginPage(mediaBox: &mediaBox)
            destContext.drawPDFPage(page)
            destContext.textMatrix = .identity
            destContext.translateBy(x: 0, y: mediaBox.height)
               destContext.scaleBy(x: 1, y: -1)
           
            
            var yDex:CGFloat=0
            switch Motif{
            case 0: yDex = 473//courses
            case 1: yDex = 340//Sport
            case 2:yDex = 522//Travail
            case 3:yDex = 432//Santé
            case 4:yDex = 396//Famille
            case 5:yDex = 293//judiciaire
            case 6:yDex = 257//mission
            default :yDex = 0

            }
            let MyOrigin=mediaBox.height-17
            let textRect = CGRect(x: 76, y: MyOrigin-(yDex+5), width: 19, height: 19)
            
            "x".draw(in: textRect, withAttributes: textFontAttributes20)
            (Prenom+" "+Nom).draw(in: CGRect(x: 123, y: MyOrigin-679, width: 400, height: 22), withAttributes: textFontAttributes11)
            DDN.Datestr.draw(in: CGRect(x: 123, y: MyOrigin-654, width: 300, height: 22), withAttributes: textFontAttributes11)
            LieuDN.draw(in: CGRect(x: 92, y: MyOrigin-631, width: 300, height: 22), withAttributes: textFontAttributes11)
             (Adresse+" "+CP+" "+Ville).draw(in: CGRect(x: 132, y: MyOrigin-606, width: 400, height: 44), withAttributes: textFontAttributes11)
            Ville.draw(in: CGRect(x: 111, y: MyOrigin-219, width: 300, height: 19), withAttributes: textFontAttributes11)
            Date().Datestr.draw(in: CGRect(x: 92, y: MyOrigin-194, width: 300, height: 19), withAttributes: textFontAttributes11)
            Date().Heurestr.draw(in: CGRect(x: 197, y: MyOrigin-194, width: 300, height: 19), withAttributes: textFontAttributes11)
            Date().Minstr.draw(in: CGRect(x: 220, y: MyOrigin-194, width: 300, height: 19), withAttributes: textFontAttributes11)
            "Date de création:".draw(in: CGRect(x: 463, y: MyOrigin-143, width: 300, height: 19), withAttributes: textFontAttributes7)
            Date().DateAndTimestr.draw(in: CGRect(x: 450, y: MyOrigin-136, width: 300, height: 19), withAttributes: textFontAttributes7)
            
            var GlobalString="Cree le: "+Date().DateAndTimestr+"; "+"Nom: "+Nom+"; "+"Prenom: "+Prenom+"; "+"Naissance: "+DDN.Datestr+" a "+LieuDN+"; "+"Adresse: "+Adresse+" "+CP+" "+Ville+"; "+"Sortie: "+Date().DateAndTimestr+"; "+"Motifs: "
            
            switch Motif{
                       case 0: GlobalString+="courses"
                       case 1: GlobalString+="sport"
                       case 2:GlobalString+="travail"
                       case 3:GlobalString+="sante"
                       case 4:GlobalString+="famille"
                       case 5:GlobalString+="judiciaire"
                       case 6:GlobalString+="missions"
            default :do{}
            }
            print(GlobalString)
            GlobalString=GlobalString.replacingOccurrences(of: "ʼ", with: "'")
             GlobalString=GlobalString.replacingOccurrences(of:"’", with: "'")
            print(GlobalString)
                
             GlobalString=GlobalString.folding(options: .diacriticInsensitive, locale: nil).onlyASCII()
            print(GlobalString)
            let MyQR=generateQRCode(from: GlobalString)!
            
            MyQR.draw(in: CGRect(x: mediaBox.width-170, y: MyOrigin-242, width: 100, height: 100))
           
            
           
           
            
            destContext.endPage()
            
            destContext.beginPage(mediaBox: &mediaBox)
            destContext.textMatrix = .identity
                       destContext.translateBy(x: 0, y: mediaBox.height)
                          destContext.scaleBy(x: 1, y: -1)
                   MyQR.draw(in: CGRect(x: 50, y: 50, width: 300, height: 300))
                  
            destContext.endPage()
        }
            

        destContext.closePDF()
        UIGraphicsEndPDFContext()
        self.tabBarController?.selectedIndex =  1
      
        
        
    }
    

  


    
    
    
    
}

extension Date{
    
    var Datestr:String{
        let DateFormateur=DateFormatter()
        DateFormateur.dateFormat="dd/MM/yyyy"
        return DateFormateur.string(from:self)
    }
    var DateAndTimestr:String{
        let DateFormateur=DateFormatter()
        DateFormateur.dateFormat="dd/MM/yyyy à HH'h'mm"
        return DateFormateur.string(from:self)
    }
   /* var DateAndTimestrSANSaccent:String{
        let DateFormateur=DateFormatter()
        DateFormateur.dateFormat="dd/MM/yy a HH:mm"
        return DateFormateur.string(from:self)
    }*/
    var Heurestr:String{
        let DateFormateur=DateFormatter()
        DateFormateur.dateFormat="HH"
        return DateFormateur.string(from:self)
    }
    var Minstr:String{
           let DateFormateur=DateFormatter()
           DateFormateur.dateFormat="mm"
           return DateFormateur.string(from:self)
       }
    
}
extension Character {
    /// A simple emoji is one scalar and presented to the user as an Emoji
    var isSimpleEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else { return false }
        return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
    }

    /// Checks if the scalars will be merged into an emoji
    var isCombinedIntoEmoji: Bool { unicodeScalars.count > 1 && unicodeScalars.first?.properties.isEmoji ?? false }

    var isEmoji: Bool { isSimpleEmoji || isCombinedIntoEmoji }
}

extension String {
    var isSingleEmoji: Bool { count == 1 && containsEmoji }

    var containsEmoji: Bool { contains { $0.isEmoji } }

    var containsOnlyEmoji: Bool { !isEmpty && !contains { !$0.isEmoji } }

    var emojiString: String { emojis.map { String($0) }.reduce("", +) }

    var emojis: [Character] { filter { $0.isEmoji } }

    var emojiScalars: [UnicodeScalar] { filter { $0.isEmoji }.flatMap { $0.unicodeScalars } }
    func withoutEmoji()->String{
        var str:String=""
        for char in self{
            if !char.isEmoji {
                str+=String(char)
            }
        }
        return str
    }
    
    func onlyASCII()->String{
       
       
        var str:String=""
            for char in self{
                   if char.isASCII {
                       str+=String(char)
                   }else{
                    
                    str+="*"
                    
                    }
               }
               return str
    }
}
