
import UIKit


fileprivate var containerView : UIView!

extension UIViewController
{
    func presentCustomAlert(alertTitle : String , alertMessage : String , btnTitle : String)
    {
        DispatchQueue.main.async {
            let vc = CustomAlertVCViewController()
            
            vc.alertTitleText = alertTitle
            vc.alertMsgText = alertMessage
            vc.alertBtnTitle = btnTitle
            
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            
            self.present(vc, animated: true)
        }
    }
    
    
    func showLoadingScreen()
    {
        containerView = UIView(frame: view.bounds)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        let loadingView = UIActivityIndicatorView(style: .large)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(loadingView)
        loadingView.startAnimating()
        
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        view.addSubview(containerView)
        
        UIView.animate(withDuration: 0.30) {
            containerView.alpha = 0.8
        }
    }
    
    func removeLoadingScreen()
    {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
}
