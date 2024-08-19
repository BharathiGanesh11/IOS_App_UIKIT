//
//  GFAvatarImageView.swift
//  GitHub Followers
//
//  Created by Kumar on 17/08/24.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeHolderImage = UIImage(named: "PlaceHolder")!
    var imageCache = GFNetworkManager.shared.cache

    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config()
    {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeHolderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadAvatar(urlString : String)
    {
        let keyStr = NSString(string: urlString)
        
        if let image = imageCache.object(forKey: keyStr)
        {
            self.image = image
            print("reterived from cache")
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self else { return }
            
            guard error == nil else { return }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else { return }
            
            guard let data = data else { return }
            
            if let image = UIImage(data: data)
            {
                DispatchQueue.main.async {
                    self.imageCache.setObject(image, forKey: keyStr)
                    self.image = UIImage(data: data)
                    print("set image to cache")
                }
            }
        }.resume()
    }
}
