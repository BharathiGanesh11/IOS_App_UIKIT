
import UIKit

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
}
