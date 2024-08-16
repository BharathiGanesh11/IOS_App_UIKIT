
import UIKit

class GFbodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment : NSTextAlignment)
    {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        config()
    }
    
    private func config()
    {
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        font = UIFont.preferredFont(forTextStyle: .body)
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
