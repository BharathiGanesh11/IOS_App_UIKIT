
import UIKit

class CustomAlertVCViewController: UIViewController {
    
    var alertTitleText : String?
    var alertMsgText : String?
    var alertBtnTitle : String?
    
    let containerView : UIView = {
        let container = UIView()
        container.layer.cornerRadius = 16
        container.layer.borderWidth = 2
        container.layer.borderColor = UIColor.white.cgColor
        container.backgroundColor = . systemBackground
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let dimmedView : UIView = {
        let container = UIView()
        container.backgroundColor = .black
        container.alpha = 0.3
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let alertTitle = GFtitleLabel(textAlignment: .center, fontSize: 22)
    let alertMsg = GFbodyLabel(textAlignment: .center)
    let actionButton = GFButton(bgColor: .systemPink, btnTitle: "Ok")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        dimmedView.frame = view.bounds
        //self.view.addSubview(dimmedView)
        configContainerView()
        configAlertTitle()
        configActionButton()
        configAlertMsg()
    }
    
    func configContainerView()
    {
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant : 280),
            containerView.heightAnchor.constraint(equalToConstant : 220)
        ])
    }
    
    func configAlertTitle()
    {
        containerView.addSubview(alertTitle)
        
        alertTitle.text = alertTitleText ?? "Something Went Wrong!"
        
        NSLayoutConstraint.activate([
            alertTitle.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15),
            alertTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            alertTitle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15)
        ])
    }
    
    func configActionButton()
    {
        containerView.addSubview(actionButton)
        
        actionButton.setTitle(alertBtnTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            actionButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func configAlertMsg()
    {
        containerView.addSubview(alertMsg)
        
        alertMsg.text = alertMsgText ?? "Unable to process the request"
        alertMsg.numberOfLines = 4

        NSLayoutConstraint.activate([
            alertMsg.topAnchor.constraint(equalTo: alertTitle.bottomAnchor, constant: 15),
            alertMsg.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            alertMsg.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            alertMsg.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -20)
        ])
    }
    
    @objc func dismissAlert()
    {
        self.dismiss(animated: true)
    }
}
