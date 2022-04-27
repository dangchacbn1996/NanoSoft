//
//  AlertTwoTreatmentButtonViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/5/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class AlertTwoTreatmentButtonViewController: SwiftPopup {
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    
    var dataModel: DetailTreatmentOptionalResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let brandType = Common.BRAND_TYPE
        if brandType == BrandTypeEnum.Staff.rawValue {
            self.callButton.isHidden = false
        } else {
            self.callButton.isHidden = true
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
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss()
    }
}
