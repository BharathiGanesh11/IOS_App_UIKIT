//
//  GFInfoItemVCViewController.swift
//  GitHub Followers
//
//  Created by Kumar on 26/08/24.
//

// Base Class for Items

import UIKit

class GFInfoItemVC: UIViewController {
    
    let InfoViewOne = GFInfoItemView(frame: .zero)
    let InfoViewTwo = GFInfoItemView(frame: .zero)
    let button = GFButton()
    let stackView = UIStackView()
    
    var user : User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configVC()
        configStackView()
        layoutUI()
    }
    
    private func configVC()
    {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func configStackView()
    {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(InfoViewOne)
        stackView.addArrangedSubview(InfoViewTwo)
    }
    
    private func layoutUI()
    {
        let padding : CGFloat = 20
        
        view.addSubview(stackView)
        view.addSubview(button)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            button.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
