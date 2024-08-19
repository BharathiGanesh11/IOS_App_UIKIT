//
//  UIHelper.swift
//  GitHub Followers
//
//  Created by Kumar on 19/08/24.
//

import UIKit


struct UIHelper
{
    static func configureThreeColumnFlowLayout(view : UIView) -> UICollectionViewFlowLayout
    {
        let fullWidth = view.bounds.width
        let padding : CGFloat = 12
        let mininumItemSpacing : CGFloat = 10
        let availableWidth = fullWidth - (2*padding) - (2*mininumItemSpacing)
        let itemWidth = availableWidth/3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        return flowLayout
    }
}
