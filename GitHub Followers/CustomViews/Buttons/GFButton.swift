
import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(bgColor : UIColor , btnTitle : String)
    {
        self.init(frame: .zero)
        self.backgroundColor = bgColor
        self.setTitle(btnTitle, for: .normal)
        setupButton()
    }
    
    private func setupButton()
    {
        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(background : UIColor , title : String)
    {
        backgroundColor = background
        setTitle(title, for: .normal)
    }
}
