//
//  UpcomingCollectionViewCell.swift
//  MovieAPI
//
//  Created by User 2 on 09/08/22.
//

import UIKit

class UpcomingCollectionViewCell: UICollectionViewCell{
    lazy var filmImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpSubviews(){
        
        self.addSubview(filmImage)
        self.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            filmImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0),
            filmImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10.0),
            filmImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10.0),
            
            nameLabel.topAnchor.constraint(equalTo: filmImage.bottomAnchor),
            nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10.0),
            nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10.0),
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}


