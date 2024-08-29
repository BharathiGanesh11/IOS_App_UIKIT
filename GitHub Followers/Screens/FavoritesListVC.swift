

import UIKit

class FavoritesListVC: UIViewController {
    
    var favorites : [Follower] = []
    let favoritesTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
        getFavorites()
    }
    
    private func configureVC()
    {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    private func getFavorites()
    {
        PersistenceManager.fetchFavorites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let favorites):
                print(favorites)
                self.favorites = favorites
                DispatchQueue.main.async {
                    self.favoritesTableView.reloadData()
                }
            case .failure(let error):
                self.presentCustomAlert(alertTitle: "Something went wrong", alertMessage: error.rawValue, btnTitle: "Ok")
            }
        }
    }
    
    private func configureTableView()
    {
        view.addSubview(favoritesTableView)
        
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
        favoritesTableView.frame = view.bounds
        favoritesTableView.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.reuseID)
    }
}

extension FavoritesListVC : UITableViewDataSource , UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.reuseID) as! FavoritesCell
        let favorite = favorites[indexPath.row]
        cell.set(favorites: favorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let followersVC = FollowersListVC()
        followersVC.title = favorite.login
        followersVC.userName = favorite.login
        self.navigationController?.pushViewController(followersVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let favorite = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        PersistenceManager.updateFavorites(actionType: .remove, with: favorite) { [weak self] error in
            guard let self = self else { return }
            
            guard let error = error else { return }
            
            self.presentCustomAlert(alertTitle: "Unable To Remove", alertMessage: error.rawValue, btnTitle: "Ok")
        }
        
    }
}
