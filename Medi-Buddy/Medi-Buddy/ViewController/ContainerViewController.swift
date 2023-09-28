//
//  ContainerViewController.swift
//  Medi-Buddy
//
//  Created by Jinah Park on 2023/09/27.
//

import UIKit

final class ContainerViewController: UIViewController {
    private var settingBarState = SettingBarState.closed
    private let settingViewController = SettingBarViewController()
    private let homeViewController = MediListViewController()
    private var navigationViewController: UINavigationController?
    private var selectedViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewController()
        configureDelegate()
    }
    
    private func addChildViewController() {
        addChild(settingViewController)
        view.addSubview(settingViewController.view)
        
        let homeNavigationViewController = UINavigationController(rootViewController: homeViewController)
        homeViewController.delegate = self
        addChild(homeNavigationViewController)
        view.addSubview(homeNavigationViewController.view)
        homeNavigationViewController.didMove(toParent: self)
        self.navigationViewController = homeNavigationViewController
    }
    
    private func configureDelegate() {
        settingViewController.delegate = self
        homeViewController.delegate = self
    }
}

extension ContainerViewController: SettingBarViewControllerDelegate {
    func didSelect(menuItem: SettingBarMenu) {
        toggleMenu(completion: nil)
        switch menuItem {
        case .main:
            resetHome()
        case .category:
            addViewController(to: ModifyCategoryViewController())
        }
    }
    
    private func addViewController(to viewController: UIViewController) {
        selectedViewController = viewController
        homeViewController.addChild(viewController)
        homeViewController.view.addSubview(viewController.view)
        viewController.view.frame = view.bounds
        viewController.didMove(toParent: homeViewController)
        homeViewController.title = viewController.title
    }
    
    private func resetHome() {
        guard let selectedViewController else { return }
        selectedViewController.view.removeFromSuperview()
        selectedViewController.didMove(toParent: nil)
        self.selectedViewController = nil
    }
}

extension ContainerViewController: MediListViewControllerDelegate {
    func didTapMenuButton() {
        toggleMenu(completion: nil)
    }
    
    private func toggleMenu(completion: ( () -> Void)? ) {
        switch settingBarState {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0,  options: .curveEaseInOut) { [weak self] in
                guard let self = self else { return }
                self.navigationViewController?.view.frame.origin.x = self.homeViewController.view.frame.size.width - 150
            } completion: { [weak self] done in
                if done {
                    self?.settingBarState = .opened
                }
            }
            
        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0,  options: .curveEaseInOut) { [weak self] in
                guard let self = self else { return }
                self.navigationViewController?.view.frame.origin.x = 0
            } completion: { [weak self] done in
                if done {
                    self?.settingBarState = .closed
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
            
        }
        
    }
}
