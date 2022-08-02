//
//  OnBoardingSecondViewController.swift
//  Yetda
//
//  Created by Geunil Park on 2022/07/21.
//

import UIKit

class OnBoardingSecondViewController: UIViewController {
    let viewModel: SearchViewModel = SearchViewModel.shared
    let searchResultViewController = SearchResultViewController(view: .OnBoarding)
    
    private var constraintArr: [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        dismissKeyboard()
        view.backgroundColor = .white
        setupUI()
        searchResultViewController.delegate = self
        
    }
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "여행지를 추가해주세요"
        searchBar.searchTextField.font =  UIFont(name: "SpoqaHanSansNeo-Regular", size: 17)
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        searchBar.showsSearchResultsButton = true
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var makeSubtitle1 : UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.text = "기념품 구매하셨나요?"
        subtitleLabel.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 25)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return subtitleLabel
    }()
    
    private lazy var makeSubtitle2: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.text = "여행지를 입력해주세요"
        subtitleLabel.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 25)
        let attributedStr = NSMutableAttributedString(string: subtitleLabel.text!)
        attributedStr.addAttribute(.foregroundColor, value: UIColor(named: "YettdaMainBlue"), range: (subtitleLabel.text! as NSString).range(of: "여행지"))
        subtitleLabel.attributedText = attributedStr
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return subtitleLabel
    }()
    
    private func setupUI() {
        self.view.addSubview(makeSubtitle1)
        let searchCon = makeSubtitle1.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 280)
        
        makeSubtitle1.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        makeSubtitle1.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        makeSubtitle1.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.view.addSubview(makeSubtitle2)
        makeSubtitle2.topAnchor.constraint(equalTo: makeSubtitle1.bottomAnchor, constant: 10).isActive = true
        makeSubtitle2.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        makeSubtitle2.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.view.addSubview(searchBar)
        NSLayoutConstraint.deactivate(constraintArr)

        let topCon = searchBar.topAnchor.constraint(equalTo: makeSubtitle2.bottomAnchor, constant: 26)
        let widthCon =  searchBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        let leadingCon = searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12)
        let trailiCon = searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
        
        constraintArr = [topCon, leadingCon, trailiCon]
        NSLayoutConstraint.activate(constraintArr)
        
        constraintArr = [searchCon]
        NSLayoutConstraint.activate(constraintArr)
    }
   
    private func setupResultViewUI() {
        searchResultViewController.view.translatesAutoresizingMaskIntoConstraints = false
        searchResultViewController.view.topAnchor.constraint(equalTo: searchBar.bottomAnchor,constant: 20).isActive = true
        searchResultViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchResultViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchResultViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension OnBoardingSecondViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        beginAppearanceTransition(true, animated: true)
        NSLayoutConstraint.deactivate(constraintArr)
        UIView.animate(withDuration: 0.33) {
            self.view.layoutIfNeeded()
            self.makeSubtitle2.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 140).isActive = true
        }
        view.addSubview(searchResultViewController.view)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            UIView.animate(withDuration: 1.2) {
                self.searchResultViewController.view.layer.opacity = 0.92
            }
            self.searchResultViewController.view.isHidden = false
        }
        self.setupResultViewUI()
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        viewModel.filterdData(text: "")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResultViewController.view.isHidden = false
        viewModel.filterdData(text: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension OnBoardingSecondViewController: GoHomeView {
    func goToHomeView() {
        self.navigationController?.popViewController(animated: true)
    }
}
