//
//  ViewController.swift
//  FinalProject
//
//  Created by Бекжан on 12.04.2023.
//

import UIKit
import SnapKit
class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let vc1 = UINavigationController(rootViewController: DSHeroesViewController())
        let vc2 = UINavigationController(rootViewController: DSTeamsViewController())
        let vc3 = UINavigationController(rootViewController: DSPlayersViewController())
        let vc4 = UINavigationController(rootViewController: DSSettingsViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "gamecontroller")
        vc1.tabBarItem.title = "Heroes"
        vc2.tabBarItem.image = UIImage(systemName: "person.3.sequence.fill")
        vc2.tabBarItem.title = "Teams"
        vc3.tabBarItem.image = UIImage(systemName: "person.fill")
        vc3.tabBarItem.title = "Players"
        vc4.tabBarItem.image = UIImage(systemName: "gear")
        vc4.title = "Settings"

        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
    }
}


