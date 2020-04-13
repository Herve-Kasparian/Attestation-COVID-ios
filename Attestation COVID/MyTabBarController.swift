//
//  MyTabBarController.swift
//  SuiviCriteres
//
//  Created by Hervé Kasparian on 03/03/2019.
//  Copyright © 2019 Hervé Kasparian. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {
   /* override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask(rawValue: UIInterfaceOrientationMask.all.rawValue)
        
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        //supportedInterfaceOrientations = UIInterfaceOrientationMask(rawValue: UIInterfaceOrientationMask.all.rawValue)
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      
            
            if #available(iOS 13.0, *) {
                
                let a = self.tabBar.items![0];a.image=UIImage(systemName: "wand.and.stars")
                let b = self.tabBar.items![1];b.image=UIImage(systemName: "qrcode")//"doc.richtext")
                let c = self.tabBar.items![2];c.image=UIImage(systemName: "person")
              //  self.tabBar.items=[a,b,c]
                
                
            } else {
               
            }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
