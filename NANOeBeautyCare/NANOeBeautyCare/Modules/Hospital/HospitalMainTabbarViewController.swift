//
//  HospitalMainTabbarViewController.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 10/04/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

class HospitalMainTabbarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "CustomerHome", bundle: nil)
//        let storySocial = UIStoryboard(name: "CustomerHome", bundle: nil)

        let navHome = MyNavigationController(rootViewController: HospitalMainViewController())
        
//        let vcAppointment = storyboard.instantiateViewController(withIdentifier: "CustomerHomeViewController")
//        let navAppointment = MyNavigationController(rootViewController: vcAppointment)
        
        let vcAppointment = storyboard.instantiateViewController(withIdentifier: "AppointmentViewController")
        let navAppointment = MyNavigationController(rootViewController: vcAppointment)
        
        let vcSocial = storyboard.instantiateViewController(withIdentifier: "CustomerSocialViewController") as! CustomerSocialViewController
        let navSocial = MyNavigationController(rootViewController: vcSocial)
        
        var navUser: MyNavigationController!
        if Common.IS_GUEST {
            let vcTreatment = storyboard.instantiateViewController(withIdentifier: "TreatmentViewController") as! TreatmentViewController
            navUser = MyNavigationController(rootViewController: vcTreatment)
        } else {
            let vcUser = storyboard.instantiateViewController(withIdentifier: "CustomerProfileViewController") as! CustomerProfileViewController
            navUser = MyNavigationController(rootViewController: vcUser)
        }
        
        
        self.viewControllers = [navHome, navAppointment, navSocial, navUser]
        
        // Do any additional setup after loading the view.
        let homeItemView = self.tabBar.items![0]
        homeItemView.image = UIImage(named: "ic-home-unselected-tabbar")
        homeItemView.selectedImage = UIImage(named: "ic-home-unselected-tabbar")
        homeItemView.title = "TabBar.Home".localize()
        
        let historyItemView = self.tabBar.items![1]
        historyItemView.image = UIImage(named: "ic-calendar-unselected-tabbar")
        historyItemView.selectedImage = UIImage(named: "ic-calendar-unselected-tabbar")
        historyItemView.title = "TabBar.Calendar".localize()

        let qrcodeItemView = self.tabBar.items![2]
        qrcodeItemView.image = UIImage(named: "ic-social-unselected-tabbar")
        qrcodeItemView.selectedImage = UIImage(named: "ic-social-unselected-tabbar")
        qrcodeItemView.title = "TabBar.Social".localize()

        let notificationItemView = self.tabBar.items![3]
        notificationItemView.image = UIImage(named: "user")
        notificationItemView.selectedImage = UIImage(named: "user")
        notificationItemView.title = "TabBar.Docter".localize()
    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
////        self.tabBarController?.navigationController?.setNavigationBarHidden(true, animated: true)
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        //        self.updateNotification()
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor(hex: "2C86F3")], for: .selected)
//        //        self.playBounceAnimation(self.tabBar.subviews[item.tag + 1].subviews[1] as! UIImageView)
//        //        if item.tag == 2 {
//        //            UIApplication.shared.applicationIconBadgeNumber = 0
//        //            UserDefaults.standard.set(UIApplication.shared.applicationIconBadgeNumber, forKey: "BadgeNumber")
//        //        }
//        //        self.updateNotification()
//    }
//
//    func playBounceAnimation(_ icon: UIImageView) {
//        //        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
//        //        bounceAnimation.values = [1.0, 1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
//        //        bounceAnimation.duration = TimeInterval(1.0)
//        //        bounceAnimation.calculationMode = kCAAnimationCubic
//        //        icon.layer.add(bounceAnimation, forKey: nil)
//    }
    
    func tabBarControllerSupportedInterfaceOrientations(_ tabBarController: UITabBarController) -> UIInterfaceOrientationMask {
        return .portrait
    }
}
