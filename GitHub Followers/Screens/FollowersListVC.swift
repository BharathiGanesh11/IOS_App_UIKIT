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
    var userName : String = "SAllen0400"
    var page = 1
    var hasMoreFollowes : Bool = true
    var collectionView : UICollectionView!
    var collectionnViewDiffableDataSource : UICollectionViewDiffableDataSource<Section, Follower>!
    var snapShot : NSDiffableDataSourceSnapshot<Section, Follower>!
    var followers : [Follower] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configureCollectionView()
        getFollowers(userName: userName, page: page)
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
    
    func getFollowers(userName : String , page : Int)
    {
        GFNetworkManager.shared.getFollowers(userName: userName, page: page) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let followers):
                if followers.count < 100
                {
                    hasMoreFollowes = false
                }
                else
                {
                    hasMoreFollowes = true
                }
                self.followers.append(contentsOf: followers)
                self.updateData()
            case .failure(let error):
                self.presentCustomAlert(alertTitle: "Alert!", alertMessage: error.rawValue, btnTitle: "Ok")
            }
        }
    }
    
    func configureCollectionView()
    {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.configureThreeColumnFlowLayout(view: view))
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
        collectionView.backgroundColor = .systemBackground
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

extension FollowersListVC : UICollectionViewDelegate
{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.height
        
        if offsetY > (contentHeight - scrollViewHeight)
        {
            guard hasMoreFollowes else { return }
            page = page + 1
            getFollowers(userName: userName, page: page)
        }
    }
}


