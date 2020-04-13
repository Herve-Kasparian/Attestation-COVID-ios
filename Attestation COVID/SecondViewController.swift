//
//  SecondViewController.swift
//  Attestation COVID
//
//  Created by Hervé Kasparian on 11/04/2020.
//  Copyright © 2020 Hervé Kasparian. All rights reserved.
//

import UIKit

let fileName = "CurrentAttestion.pdf"

       let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
       let documentsDirectory = paths[0] as NSString
       let pathForPDF = documentsDirectory.appending("/" + fileName)
let ExportURL=URL(fileURLWithPath: pathForPDF)

class SecondViewController: UIViewController {

    @IBOutlet var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

       
       
    }
    override func viewWillAppear(_ animated: Bool) {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: pathForPDF){
         webView.loadRequest(URLRequest(url: ExportURL))
        }else{
            self.tabBarController?.selectedIndex=0
        }
    }

    
    @IBAction func SendDidTouch(_ sender: Any) {
        let activityViewController = UIActivityViewController(
                    activityItems: [ExportURL],
                    applicationActivities: nil)
                        
               #if !targetEnvironment(macCatalyst)
                   
               activityViewController.setValue("Attestation COVID", forKey: "subject")
                            
               #endif

                if let popover = activityViewController.popoverPresentationController {
                    popover.barButtonItem  = self.navigationItem.rightBarButtonItem
                    popover.permittedArrowDirections = .up
                }
                
                
                present(activityViewController, animated: true, completion: nil)
    }
}

