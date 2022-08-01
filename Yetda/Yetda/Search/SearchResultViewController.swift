//
//  SearchResultViewController.swift
//  Yetda
//
//  Created by rbwo on 2022/07/26.
//

import UIKit
import Combine

protocol GoHomeView {
    func goToHomeView()
}

class SearchResultViewController: UIViewController {
    var delegate: GoHomeView?
    var dismissView: SuperView?
    
    enum SuperView {
        case OnBoarding
        case Nothing
    }
    
    init(view: SuperView) {
        self.dismissView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!
    var subscriptions = Set<AnyCancellable>()
    
    let viewModel: SearchViewModel = SearchViewModel.shared
    
    private lazy var emptyView: UIView = {
        var emptyLabel = UILabel()
        emptyLabel.textColor = .label
        emptyLabel.text = "여행지를 검색해보세요!"
        emptyLabel.font = .systemFont(ofSize: 20)
        emptyLabel.numberOfLines = 0
        
        var emptyView = UIView()
        emptyView.backgroundColor = .systemBackground
        emptyView.addSubview(emptyLabel)
        emptyView.isHidden = true
        return emptyView
    }()
    
    private lazy var collectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.delegate = self
        collectionView.keyboardDismissMode = .onDrag
        collectionView.register(SearchSiteCell.self, forCellWithReuseIdentifier: SearchSiteCell.reuseIdentifier)
        collectionView.collectionViewLayout = layout()
        collectionView.delegate = self
        return collectionView
    }()
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch dismissView {
        case .Nothing :
            self.emptyView.backgroundColor = UIColor(named: "YettdaMainBackground")
            self.collectionView.backgroundColor = UIColor(named: "YettdaMainBackground")
        case .OnBoarding :
            return
        case .none :
            return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureCollectionView()
        bind()
        prepareTapGesture()
    }
    
    private func prepareTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        emptyView.addGestureRecognizer(tapGesture)
    }
    @objc func handleTap(sender: UITapGestureRecognizer) {
        switch dismissView {
        case .OnBoarding :
            return
        case .Nothing :
            self.view.removeFromSuperview()
        case .none :
            return
        }
    }
    
    private func setupUI() {
        [collectionView, emptyView].forEach { view.addSubview($0) }
        
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: view.topAnchor),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func applySnapshot(items: [String], section: Section){
        var snapshot = dataSource.snapshot()
        if snapshot.numberOfItems != 0 {
            snapshot.deleteAllItems()
            snapshot.appendSections([.main])
        }
        snapshot.appendItems(items, toSection: section)
        dataSource.apply(snapshot)
    }
    
    private func bind() {
        viewModel.$resultData
            .receive(on: RunLoop.main)
            .sink { item in
                self.applySnapshot(items: item, section: .main)
                let isEmpty = self.viewModel.resultData.count == 0
                self.collectionView.isHidden = isEmpty
                self.emptyView.isHidden = !isEmpty
            }.store(in: &subscriptions)
    }
    
    private func configureCollectionView() {
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchSiteCell.reuseIdentifier, for: indexPath) as? SearchSiteCell else { return nil }
            
            cell.configure(item)
            return cell
        })

        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems([], toSection: .main)
        dataSource.apply(snapshot)
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let spacing: CGFloat = 10
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.08))
        let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: itemLayout, count: 1)
    
        let section = NSCollectionLayoutSection(group: groupLayout)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        section.interGroupSpacing = spacing
        return UICollectionViewCompositionalLayout(section: section)
    }
    private func homeViewWillAppear(city: String?) {
        self.view.window?.rootViewController?.dismiss(animated: false, completion: {
            let homeVC = UINavigationController(rootViewController: HomeViewController(city: city))
            let sd = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
            sd.window?.rootViewController = homeVC
        })
    }
}

extension SearchResultViewController: UICollectionViewDelegate {
    // TODO: 셀 클릭시, 여행지 리스트 Cell에 추가하는 로직
    /// 유저 디폴트 리스트에 해당 여행지의 문자열 append
    /// HomeView로 이동하여 해당 여행지의 타이틀 전달
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SearchSiteCell {
            let pressedDownTransform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 3, options: [.curveEaseInOut], animations: { cell.transform = pressedDownTransform })
        }
        let site = viewModel.resultData[indexPath.item]
        defaults.set(site.localized, forKey: "site")
        defaults.set(true, forKey: "isFirst")
        
        // MARK: Delegate로 가면 홈뷰의 UI가 조금 깨짐,,
        //self.delegate?.goToHomeView()
        switch dismissView {
        case .OnBoarding :
            setSiteUserDefault(site: site)
            homeViewWillAppear(city: defaults.string(forKey: "site"))
        case .Nothing :
            setSiteUserDefault(site: site)
            homeViewWillAppear(city: defaults.string(forKey: "site"))
        case .none:
            return
        }
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SearchSiteCell {
            let originalTransform = CGAffineTransform(scaleX: 1, y: 1)
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 3, options: [.curveEaseInOut], animations: { cell.transform = originalTransform })
        }
    }
}

extension SearchResultViewController {
    // UserDefault 값 넣는 함수
    func setSiteUserDefault(site: String) {
        let siteList: [String] = [site]
        if var siteList = defaults.array(forKey: "sites") {
            siteList.append(site)
            defaults.set(siteList, forKey: "sites")
        } else {
            defaults.set(siteList, forKey: "sites")
        }
    }
}
