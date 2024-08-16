

import UIKit

class FavoritesListVC: UIViewController {
    
    var userName : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBlue
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = userName
        
        GFNetworkManager.shared.getFollowers(userName: "SAllen0400", page: 1) { result in
            switch result {
            case .success(let followers):
                print(followers.count)
                print(followers)
            case .failure(let error):
                self.presentCustomAlert(alertTitle: "Alert!", alertMessage: error.rawValue, btnTitle: "Ok")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
