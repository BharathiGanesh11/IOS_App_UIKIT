

import UIKit

class SearchListVC: UIViewController {
    
    let logoImg = UIImageView()
    let userTxtField = GFTextField()
    let followersButton = GFButton(bgColor: .systemGreen, btnTitle: "Get Followers")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        configFollowersButton()
        configLogoImg()
        configUserTxtField()
        configTapForView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func configLogoImg()
    {
        logoImg.translatesAutoresizingMaskIntoConstraints = false
        logoImg.image = UIImage(named: "Logo")
        logoImg.contentMode = .scaleAspectFit
        
        view.addSubview(logoImg)
        NSLayoutConstraint.activate([
            logoImg.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImg.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImg.widthAnchor.constraint(equalToConstant: 200),
            logoImg.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configUserTxtField()
    {
        view.addSubview(userTxtField)
        userTxtField.keyboardType = .default
        userTxtField.returnKeyType = .go
        userTxtField.delegate = self
        
        NSLayoutConstraint.activate([
            userTxtField.topAnchor.constraint(equalTo: logoImg.bottomAnchor, constant: 48),
            userTxtField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userTxtField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userTxtField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configFollowersButton()
    {
        view.addSubview(followersButton)
        
        followersButton.addTarget(self, action: #selector(navigate), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            followersButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            followersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            followersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            followersButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configTapForView()
    {
        let closeKeyboardTap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        self.view.addGestureRecognizer(closeKeyboardTap)
    }
    
    @objc func navigate()
    {
        guard isUserNameEntered else {
            self.presentCustomAlert(alertTitle: "Alert!", alertMessage: "please type a username to search followes!...", btnTitle: "Ok")
            return
        }
        let vc = FavoritesListVC()
        vc.userName = userTxtField.text ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    var isUserNameEntered : Bool
    {
        let userName = userTxtField.text ?? ""
        return !userName.isEmpty
    }
}

extension SearchListVC : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        navigate()
        return true
    }
}
