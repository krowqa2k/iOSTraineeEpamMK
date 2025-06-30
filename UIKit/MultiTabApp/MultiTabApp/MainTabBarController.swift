//
//  MainTabBarController.swift
//  MultiTabApp
//
//  Created by Mateusz Krówczyński on 29/06/2025.
//

import Foundation
import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupTabBarAppearance()
    }

    private func setupTabs() {
        let onboardingVC = OnboardingViewController()
        let onboardingNav = UINavigationController(rootViewController: onboardingVC)
        onboardingNav.tabBarItem = UITabBarItem(title: "Onboarding", image: UIImage(systemName: "hand.raised.fill"), tag: 0)

        let profileVC = ProfileViewController()
        let profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 1)

        let settingsVC = SettingsViewController()
        let settingsTab = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape.fill"), tag: 2)
        settingsVC.tabBarItem = settingsTab

        viewControllers = [onboardingNav, profileNav, settingsVC]
    }

    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .orange

        let unselectedAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.lightGray]
        appearance.stackedLayoutAppearance.normal.iconColor = .lightGray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = unselectedAttributes

        let selectedAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
        appearance.stackedLayoutAppearance.selected.iconColor = .white
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttributes

        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
}
