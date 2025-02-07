//
//  FollowersListVC.swift
//  GitHub Followers
//
//  Created by Kumar on 17/08/24.
//

import UIKit

protocol FollowersListVCDelegate : AnyObject
{
    func reloadWithNewUser(username : String)
}

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
    var filteredFollowers : [Follower] = []
    var isFiltered : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configureSearchController()
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
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToFavorites))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func getFollowers(userName : String , page : Int)
    {
        showLoadingScreen()
        GFNetworkManager.shared.getFollowers(userName: userName, page: page) { [weak self] result in
            guard let self = self else { return }
            self.removeLoadingScreen()
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
                
                if self.followers.isEmpty
                {
                    DispatchQueue.main.async {
                        let emptyStateMessage = "There is no followers for this account,do follow this account 😀..!"
                        self.showFollowerEmptyState(message: emptyStateMessage, in: self.view)
                        return
                    }
                }
                
                self.updateData(followers: self.followers)
            case .failure(let error):
                self.presentCustomAlert(alertTitle: "Alert!", alertMessage: error.rawValue, btnTitle: "Ok")
            }
        }
    }
    
    func configureSearchController()
    {
        let searchVc = UISearchController()
        searchVc.searchResultsUpdater = self
        searchVc.searchBar.delegate = self
        navigationItem.searchController = searchVc
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
    
    func updateData(followers : [Follower])
    {
        snapShot = NSDiffableDataSourceSnapshot()
        snapShot.appendSections([.main])
        snapShot.appendItems(followers)
        DispatchQueue.main.async {
            self.collectionnViewDiffableDataSource.apply(self.snapShot, animatingDifferences: true)
        }
    }
    
    func ShowUserInfoVC(userName : String)
    {
        let userInfoVc = UserInfoVCV()
        userInfoVc.userName = userName
        userInfoVc.delegate = self
        let vc = UINavigationController(rootViewController: userInfoVc)
        present(vc, animated: true)
    }
    
    @objc func addToFavorites()
    {
        GFNetworkManager.shared.getUserInfo(userName: userName) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let userInfo):
                let favorite = Follower(login: userInfo.login, avatarUrl: userInfo.avatarUrl)
                PersistenceManager.updateFavorites(actionType: .add, with: favorite) { error in
                    guard let error = error else {
                        self.presentCustomAlert(alertTitle: "GitHub", alertMessage: GFError.addedToFavoriteList.rawValue, btnTitle: "Ok")
                        return
                    }
                    
                    self.presentCustomAlert(alertTitle: "Something went wrong", alertMessage: error.rawValue, btnTitle: "Ok")
                    
                }
            case .failure(let error):
                self.presentCustomAlert(alertTitle: "Something went wrong", alertMessage: error.rawValue, btnTitle: "Ok")
            }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userName = isFiltered ? filteredFollowers[indexPath.row].login : followers[indexPath.row].login
        ShowUserInfoVC(userName: userName)
    }
}

extension FollowersListVC : UISearchBarDelegate , UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController) {
        guard let filterText = searchController.searchBar.text , !filterText.isEmpty
        else
        {
            return
        }
        
        isFiltered = true
        
        filteredFollowers = followers.filter({ $0.login.lowercased().contains(filterText.lowercased()) })
        updateData(followers: filteredFollowers)
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(followers: followers)
        isFiltered = false
    }
}

extension FollowersListVC : FollowersListVCDelegate
{
    func reloadWithNewUser(username: String) {
        title = username
        userName = username
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        getFollowers(userName: userName, page: page)
        collectionView.setContentOffset(.zero, animated: true)
    }
}


