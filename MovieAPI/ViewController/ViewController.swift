//
//  ViewController.swift
//  MovieAPI
//
//  Created by User 2 on 09/08/22.
//

import UIKit

class ViewController: UITabBarController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        let homeVC = HomeVC()
        let popularVC = PopularViewController()
        let topRatedVC = TopRatedViewController()
        let upcomingVC = UpcomingViewController()
        let profileVC = ProfileViewController()
        
        self.setViewControllers([homeVC,popularVC,topRatedVC,upcomingVC,profileVC], animated: true)
        guard let items = self.tabBar.items else{return}
        
        let images = ["house","line.3.crossed.swirl.circle","hand.thumbsup.circle","bell","person"]
        
        for x in 0...4{
            items[x].image = UIImage(systemName: images[x])
        }
    }


}




