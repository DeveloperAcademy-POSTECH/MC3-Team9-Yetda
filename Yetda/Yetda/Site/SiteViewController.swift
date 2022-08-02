//
//  SiteViewController.swift
//  Yetda
//
//  Created by 김보승 on 2022/07/19.
//

import UIKit
import RxSwift
import RxCocoa
import Hero
import Combine

class SiteViewController: UIViewController {
    let viewModel: SearchViewModel = SearchViewModel.shared
    let searchResultViewController = SearchResultViewController(view: .Nothing)
    
    var delegate: SendUpdateDelegate?
    
    @Published var list: [String] = []
    var subscriptions = Set<AnyCancellable>()
    
    @IBOutlet weak var siteViewAirplaneIcon: UIImageView!
    @IBOutlet weak var siteTitleLabel: UILabel!
    @IBOutlet weak var siteViewButton: UIButton!
    @IBOutlet weak var siteCollectionView: UICollectionView!
    @IBOutlet var siteView: UIView!
    
    let disposeBag = DisposeBag()

    enum Section {
        case main
    }
    var siteDataSource: UICollectionViewDiffableDataSource<Section, String>!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let list = defaults.array(forKey: "sites") {
            self.list = list as? [String] ?? ["error"]
        } else {
            list = []
        }
        
//        let vc = HomeViewController(city: defaults.string(forKey: "site"))
//        vc.modalPresentationStyle = .overfullScreen
//        self.present(vc, animated: true)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        siteCollectionView.collectionViewLayout = layout()
        siteCollectionView.delegate = self
        hideKeyboardWhenTappedAround()
        dismissKeyboard()
        
        siteDataSource = UICollectionViewDiffableDataSource<Section,String>(collectionView: siteCollectionView, cellProvider: {
            collectionView, indexPath, item in
            guard let siteCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SiteCell", for: indexPath)
                    as? SiteCell else {
                return nil
            }
            siteCell.configure(item)
            return siteCell})
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems([], toSection: .main)
        siteDataSource.apply(snapshot)
    
        self.hero.isEnabled = true
        self.hero.modalAnimationType = .fade
        bindTouch()
        makeSearchBar()
        bind()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.delegate?.updateCity(city: defaults.string(forKey: "site"))
    }
    
    private lazy var siteSearchBar: UISearchBar = {
        let siteSearchBar = UISearchBar()
        siteSearchBar.placeholder = "여행지를 추가해주세요"
        siteSearchBar.searchBarStyle = .minimal
        siteSearchBar.backgroundColor = UIColor(named: "YettdaMainBackground")
        siteSearchBar.sizeToFit()
        siteSearchBar.frame.size.width = siteCollectionView.frame.size.width
        siteSearchBar.layer.cornerRadius = 30
        siteSearchBar.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        
        siteSearchBar.delegate = self
        return siteSearchBar
    }()
    
    func makeSearchBar() {
        siteView.addSubview(siteSearchBar)
        siteSearchBar.translatesAutoresizingMaskIntoConstraints = false
        
        siteSearchBar.topAnchor.constraint(equalTo: siteView.topAnchor, constant: 180).isActive = true
        siteSearchBar.widthAnchor.constraint(equalToConstant: siteCollectionView.frame.size.width).isActive = true
        siteSearchBar.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        let directionalMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: -20, trailing: 20)
        siteSearchBar.directionalLayoutMargins = directionalMargins
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        
        let UICClayoutInsetSize: CGFloat = UIScreen.main.bounds.width - 40
        let spacingSize: CGFloat = 20
        
        let itemsize = NSCollectionLayoutSize(widthDimension: .absolute(UICClayoutInsetSize), heightDimension: .estimated(100))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemsize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let groupLayout = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [itemLayout])
        
        let section = NSCollectionLayoutSection(group: groupLayout)
        section.contentInsets = NSDirectionalEdgeInsets(top: 53, leading: 20, bottom: 0, trailing: 20)
        section.interGroupSpacing = spacingSize
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    @IBAction func myPageButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "MyPageView", bundle: nil)
        guard let childVC = storyboard.instantiateViewController(withIdentifier: "MyPageViewController") as? MyPageViewController else { return }
        childVC.view.backgroundColor = UIColor(named: "YettdaMainBackground")
        childVC.modalPresentationStyle = .formSheet
        self.present(childVC, animated: true)
    }
    
    private func bindTouch() {
        siteCollectionView.rx.itemSelected.bind { indexPath in
            self.siteCollectionView.deselectItem(at: indexPath, animated: true)
            let vc = HomeViewController(city: self.list[0])
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }.disposed(by: disposeBag)
    }
    
    private func applySnapshot(items: [String], section: Section){
        var snapshot = siteDataSource.snapshot()
        if snapshot.numberOfItems != 0 {
            snapshot.deleteAllItems()
            snapshot.appendSections([.main])
        }
        snapshot.appendItems(items, toSection: section)
        siteDataSource.apply(snapshot)
    }
    
    private func bind() {
        $list
            .receive(on: RunLoop.main)
            .sink { item in
                self.applySnapshot(items: item, section: .main)
            }.store(in: &subscriptions)
    }
    
    private func setupResultViewUI() {
        searchResultViewController.view.translatesAutoresizingMaskIntoConstraints = false
        searchResultViewController.view.topAnchor.constraint(equalTo: siteSearchBar.bottomAnchor,constant: -4).isActive = true
        searchResultViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchResultViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchResultViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension SiteViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        beginAppearanceTransition(true, animated: true)
        view.addSubview(searchResultViewController.view)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.searchResultViewController.view.layer.cornerRadius = 2
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
        let checkSearchView = view.subviews.filter { $0 == searchResultViewController.view }
        if checkSearchView.isEmpty {
            view.addSubview(searchResultViewController.view)
            self.setupResultViewUI()
        }
        searchResultViewController.view.isHidden = false
        viewModel.filterdData(text: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension SiteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        defaults.set(siteDataSource.itemIdentifier(for: indexPath), forKey: "site")
        self.dismiss(animated: false)
    }
}

protocol SendUpdateDelegate {
    func updateCity(city: String?)
}
