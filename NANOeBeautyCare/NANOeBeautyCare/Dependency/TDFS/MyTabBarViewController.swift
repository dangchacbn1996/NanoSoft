//
//  MyTabBarViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//


import UIKit

class MyTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
         let homeItemView = self.tabBar.items![0]
         homeItemView.image = UIImage(named: "ic-custommer-unselected-tabbar")?.withRenderingMode(.alwaysTemplate)
         homeItemView.selectedImage = UIImage(named: "ic-custommer-active-tabbar")?.withRenderingMode(.alwaysTemplate)
         homeItemView.title = "TabBar.Customer".localize()
        
         let historyItemView = self.tabBar.items![1]
         historyItemView.image = UIImage(named: "ic-calendar-unselected-tabbar")?.withRenderingMode(.alwaysTemplate)
         historyItemView.selectedImage = UIImage(named: "ic-calendar-active-tabbar")?.withRenderingMode(.alwaysTemplate)
         historyItemView.title = "TabBar.Calendar".localize()
        
         let qrcodeItemView = self.tabBar.items![2]
         qrcodeItemView.image = UIImage(named: "ic-sale-unselected-tabbar")?.withRenderingMode(.alwaysTemplate)
         qrcodeItemView.selectedImage = UIImage(named: "ic-sale-active-tabbar")?.withRenderingMode(.alwaysTemplate)
         qrcodeItemView.title = "TabBar.Sale".localize()
        
         let notificationItemView = self.tabBar.items![3]
         notificationItemView.image = UIImage(named: "ic-docter-unselected-tabbar")?.withRenderingMode(.alwaysTemplate)
         notificationItemView.selectedImage = UIImage(named: "ic-docter-active-tabbar")?.withRenderingMode(.alwaysTemplate)
         notificationItemView.title = "TabBar.Docter".localize()
        
         let moreItemView = self.tabBar.items![4]
         moreItemView.image = UIImage(named: "ic-report-unselected-tabbar")?.withRenderingMode(.alwaysTemplate)
         moreItemView.selectedImage = UIImage(named: "ic-report-active-tabbar")?.withRenderingMode(.alwaysTemplate)
         moreItemView.title = "TabBar.Report".localize()
        
        self.tabBar.backgroundImage = UIImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        self.updateNotification()
    }
    
    //    @objc func updateNotification() {
    //        if !(UIApplication.topViewController()! is NotificationViewController) {
    //            if let tabItems = self.tabBar.items {
    //                let tabbarNumber = UserDefaults.standard.integer(forKey: "BadgeNumber") ?? 0
    //                if tabbarNumber == 0 {
    //                    // In this case we want to modify the badge number of the third tab:
    //                    let tabItem = tabItems[2]
    //                    tabItem.badgeValue = nil
    //                } else {
    //                    // In this case we want to modify the badge number of the third tab:
    //                    let tabItem = tabItems[2]
    //                    tabItem.badgeValue = "\(tabbarNumber)"
    //                }
    //            }
    //        } else {
    //            NotificationCenter.default.post(name: NotificationKeys.updateNotificationView, object: nil)
    //        }
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
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: AppColors.primaryColor], for: .selected)
        //        self.playBounceAnimation(self.tabBar.subviews[item.tag + 1].subviews[1] as! UIImageView)
        //        if item.tag == 2 {
        //            UIApplication.shared.applicationIconBadgeNumber = 0
        //            UserDefaults.standard.set(UIApplication.shared.applicationIconBadgeNumber, forKey: "BadgeNumber")
        //        }
        //        self.updateNotification()
    }
    
    func playBounceAnimation(_ icon: UIImageView) {
        //        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        //        bounceAnimation.values = [1.0, 1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        //        bounceAnimation.duration = TimeInterval(1.0)
        //        bounceAnimation.calculationMode = kCAAnimationCubic
        //        icon.layer.add(bounceAnimation, forKey: nil)
    }
    
    func tabBarControllerSupportedInterfaceOrientations(_ tabBarController: UITabBarController) -> UIInterfaceOrientationMask {
        return .portrait
    }
}
