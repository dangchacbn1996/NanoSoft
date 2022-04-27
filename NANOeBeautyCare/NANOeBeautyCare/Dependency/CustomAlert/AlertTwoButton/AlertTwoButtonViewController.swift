//
//  AlertTwoButtonViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/5/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit
import MessageUI

class AlertTwoButtonViewController: SwiftPopup, MFMessageComposeViewControllerDelegate {
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    
    var dataModel: AppointmentOptionalResponse?
    var dataModelTreatment: TreatmentOptionalResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
    
    @IBAction func callButtonAction(_ sender: Any) {
        if let model = self.dataModel {
            if let url = URL(string: "tel://\(model.soDienThoai ?? "")") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        if let model = self.dataModelTreatment {
            if let url = URL(string: "tel://\(model.dienThoai ?? "")") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func messageButtonAction(_ sender: Any) {
        if let model = self.dataModel {
            if MFMessageComposeViewController.canSendText() {
                let messageComposeViewController = MFMessageComposeViewController()
                messageComposeViewController.messageComposeDelegate  = self
                
                messageComposeViewController.body = ""
                
                messageComposeViewController.recipients = [model.soDienThoai ?? ""]
                
                present(messageComposeViewController, animated: true, completion: nil)
            }
        }
        if let model = self.dataModelTreatment {
            if MFMessageComposeViewController.canSendText() {
                let messageComposeViewController = MFMessageComposeViewController()
                messageComposeViewController.messageComposeDelegate  = self
                messageComposeViewController.body = ""
                messageComposeViewController.recipients = [model.dienThoai ?? ""]
                present(messageComposeViewController, animated: true, completion: nil)
            }
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
}
