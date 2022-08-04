//
//  SiteViewController.swift
//  Yetda
//
//  Created by 김보승 on 2022/07/19.
//

import UIKit
import Hero
import Combine

class SiteViewController: UIViewController {
    let viewModel: SearchViewModel = SearchViewModel.shared
    let searchResultViewController = SearchResultViewController(view: .Nothing)
    
    var delegate: SendUpdateDelegate?
    
    private var isAppend: Bool = true
    
    @Published var siteList: [Site] = []
    var subscriptions = Set<AnyCancellable>()
    
    @IBOutlet weak var siteViewAirplaneIcon: UIImageView!
    @IBOutlet weak var siteTitleLabel: UILabel!
    @IBOutlet weak var siteViewButton: UIButton!
    @IBOutlet weak var siteCollectionView: UICollectionView!
    @IBOutlet var siteView: UIView!
    
    typealias Item = Site
    enum Section {
        case main
    }
    var siteDataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let list = defaults.array(forKey: "sites") as? [String] {
            list.map { item in
                self.siteList.forEach { Site in
                    if Site.name == item {
                        self.isAppend = false
                    }
                }
                if self.isAppend {
                    self.siteList.append(Site(name: item))
                } else {
                    self.isAppend = true
                }
            }
        } else {
            siteList = []
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        siteCollectionView.collectionViewLayout = layout()
        siteCollectionView.delegate = self
        hideKeyboardWhenTappedAround()
        dismissKeyboard()
        
        siteDataSource = UICollectionViewDiffableDataSource<Section,Item>(collectionView: siteCollectionView, cellProvider: {
            collectionView, indexPath, item in
            guard let siteCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SiteCell", for: indexPath)
                    as? SiteCell else {
                return nil
            }
            siteCell.configure(item)
            return siteCell})
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems([], toSection: .main)
        siteDataSource.apply(snapshot)
    
        self.hero.isEnabled = true
        self.hero.modalAnimationType = .fade
        makeSearchBar()
        bind()
        
        NotificationCenter.default.addObserver(self, selector: #selector(dismissSelf(notification:)), name: Notification.Name.siteView, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.delegate?.updateCity(city: defaults.string(forKey: "site"))
    }
    
    @objc func dismissSelf(notification: Notification) {
        self.dismiss(animated: true)
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
        childVC.modalPresentationStyle = .overFullScreen
        self.present(childVC, animated: true)
    }
    
    private func applySnapshot(items: [Site], section: Section){
        var snapshot = siteDataSource.snapshot()
        if snapshot.numberOfItems != 0 {
            snapshot.deleteAllItems()
            snapshot.appendSections([.main])
        }
        snapshot.appendItems(items, toSection: section)
        siteDataSource.apply(snapshot)
    }
    
    private func bind() {
        $siteList
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
        let site = siteDataSource.itemIdentifier(for: indexPath)?.name
        
        guard let site = site else { return }
                
        let firstUpper = site.first?.uppercased()
        let restString = String(site[site.index(after: site.startIndex)...])

        guard let first = firstUpper else { return }
        let siteName = first + restString
        
        let currentSite = SiteCell.imageList[site] ?? "\(siteName)"
        
        defaults.set(currentSite, forKey: "site")
        self.dismiss(animated: true)
    }
}

protocol SendUpdateDelegate {
    func updateCity(city: String?)
}


extension Notification.Name {
    static let siteView = Notification.Name("siteView")
    static let onBoardingView = Notification.Name("onBoardingView")
}
