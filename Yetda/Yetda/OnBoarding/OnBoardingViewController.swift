//
//  OnBoardingPageViewController.swift
//  OnBoardingViewApp
//
//  Created by Geunil Park on 2022/07/21.
//

import UIKit

class OnBoardingViewController: UIPageViewController {

    var pages: [UIViewController] = []
    
    var updateDelegate: SendUpdateDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.makePageVC()
        for recognizer in self.gestureRecognizers {
            recognizer.isEnabled = false
        }
        NotificationCenter.default.addObserver(self, selector: #selector(dismissSelf(notification:)), name: Notification.Name.onBoardingView, object: nil)
    }
    
    func makePageVC() {
        let itemVC1 = OnBoardingFirstViewController()
        let itemVC2 = OnBoardingSecondViewController()
        
        pages.append(itemVC1)
        pages.append(itemVC2)
        
        setViewControllers([itemVC1], direction: .forward, animated: true, completion: nil)
        
        self.dataSource = self
    }
    
    func goToNextPage(index: Int) {
        setViewControllers([pages[index]], direction: .forward, animated: true, completion: nil)
    }
    
    @objc func dismissSelf(notification: Notification) {
          self.updateDelegate?.updateCity(city: defaults.string(forKey: "site"))
          self.dismiss(animated: true)
      }
}

extension OnBoardingViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        if currentIndex == 0 {
            return pages.last
        } else {
            return pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        if currentIndex == pages.count - 1 {
            return pages.first
        } else {
            return pages[currentIndex + 1]
        }
    }
    
}
