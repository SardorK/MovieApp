//
//  InfoCell.swift
//  MovieAPI
//
//  Created by User 2 on 19/08/22.
//

import UIKit

class InfoCell: UICollectionViewCell{
    
    lazy var filmImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 3
        view.font = .systemFont(ofSize: 20.0, weight: .bold)
        
        return view
    }()
    
    lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 10.0, weight: .medium)
        
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
        self.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            filmImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0),
            filmImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10.0),
            filmImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10.0),
            
            nameLabel.topAnchor.constraint(equalTo: filmImage.bottomAnchor),
            nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10.0),
            nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10.0),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10.0),
            descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10.0),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

