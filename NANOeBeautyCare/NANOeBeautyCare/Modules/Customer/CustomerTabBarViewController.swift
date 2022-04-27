//
//  CustomerTabBarViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/22/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit


class CustomerTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        let homeItemView = self.tabBar.items![0]
        homeItemView.image = UIImage(named: "ic-home-unselected-tabbar")?.withRenderingMode(.alwaysOriginal)
        homeItemView.selectedImage = UIImage(named: "ic-home-active-tabbar")?.withRenderingMode(.alwaysOriginal)
        homeItemView.title = "TabBar.Home".localize()
        
        let historyItemView = self.tabBar.items![1]
        historyItemView.image = UIImage(named: "ic-calendar-unselected-tabbar")?.withRenderingMode(.alwaysOriginal)
        historyItemView.selectedImage = UIImage(named: "ic-calendar-active-tabbar")?.withRenderingMode(.alwaysOriginal)
        historyItemView.title = "TabBar.Calendar".localize()
        
        let qrcodeItemView = self.tabBar.items![2]
        qrcodeItemView.image = UIImage(named: "ic-social-unselected-tabbar")?.withRenderingMode(.alwaysOriginal)
        qrcodeItemView.selectedImage = UIImage(named: "ic-social-active-tabbar")?.withRenderingMode(.alwaysOriginal)
        qrcodeItemView.title = "TabBar.Social".localize()
        
        let notificationItemView = self.tabBar.items![3]
        notificationItemView.image = UIImage(named: "ic-docter-unselected-tabbar")?.withRenderingMode(.alwaysOriginal)
        notificationItemView.selectedImage = UIImage(named: "ic-docter-active-tabbar")?.withRenderingMode(.alwaysOriginal)
        notificationItemView.title = "TabBar.Docter".localize()
        
        let moreItemView = self.tabBar.items![4]
        moreItemView.image = UIImage(named: "ic-menu-unselected-tabbar")?.withRenderingMode(.alwaysOriginal)
        moreItemView.selectedImage = UIImage(named: "ic-menu-active-tabbar")?.withRenderingMode(.alwaysOriginal)
        moreItemView.title = "TabBar.More".localize()
        
        
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
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor(hex: "2C86F3")], for: .selected)
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
