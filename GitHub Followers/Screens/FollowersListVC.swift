//
//  FollowersListVC.swift
//  GitHub Followers
//
//  Created by Kumar on 17/08/24.
//

import UIKit

class FollowersListVC : UIViewController
{
    enum Section { case main }
    var userName : String = ""
    var collectionView : UICollectionView!
    var collectionnViewDiffableDataSource : UICollectionViewDiffableDataSource<Section, Follower>!
    var snapShot : NSDiffableDataSourceSnapshot<Section, Follower>!
    var followers : [Follower] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configureCollectionView()
        getFollowers()
        configureDiffableDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureVC()
    {
        self.view.backgroundColor = .systemBlue
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = userName
    }
    
    func getFollowers()
    {
        GFNetworkManager.shared.getFollowers(userName: "SAllen0400", page: 1) { result in
            switch result {
            case .success(let followers):
                self.followers = followers
                self.updateData()
            case .failure(let error):
                self.presentCustomAlert(alertTitle: "Alert!", alertMessage: error.rawValue, btnTitle: "Ok")
            }
        }
    }
    
    func configureCollectionView()
    {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: configureFlowLayout())
        view.addSubview(collectionView)
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
        collectionView.backgroundColor = .systemBackground
    }
    
    func configureFlowLayout() -> UICollectionViewFlowLayout
    {
        let fullWidth = view.bounds.width
        let padding : CGFloat = 12
        let mininumItemSpacing : CGFloat = 10
        let availableWidth = fullWidth - (2*padding) - (2*mininumItemSpacing)
        let itemWidth = availableWidth/3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        return flowLayout
    }
    
    func configureDiffableDataSource()
    {
        collectionnViewDiffableDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func updateData()
    {
        snapShot = NSDiffableDataSourceSnapshot()
        snapShot.appendSections([.main])
        snapShot.appendItems(followers)
        DispatchQueue.main.async {
            self.collectionnViewDiffableDataSource.apply(self.snapShot, animatingDifferences: true)
        }
    }
}
