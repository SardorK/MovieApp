//
//  FilmInfo.swift
//  MovieAPI
//
//  Created by User 2 on 12/08/22.
//

import UIKit

class FilmInfo: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate{
    var movies : Movie?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoCell", for: indexPath) as? InfoCell else{
            return UICollectionViewCell()
        }
        
        cell.nameLabel.text = "\(String(describing: movies?.originalTitle))"
        cell.filmImage.loadFrom(URLAddress: "https://image.tmdb.org/t/p/w500" + "\(movies?.posterPath)")
        cell.descriptionLabel.text = "\(movies?.overview)"
        return cell
    }
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(InfoCell.self, forCellWithReuseIdentifier: "InfoCell")
        view.dataSource = self
        view.delegate = self
        
        return view
    }()
    
    func createLayout()-> UICollectionViewCompositionalLayout{
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets.trailing = 5.0
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/2)), subitems: [item])
        group.contentInsets.bottom = 5.0
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubviews()
        
    }
    
    func setSubviews(){
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200.0),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10.0),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10.0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10.0),
        ])
        PopularListMovieLoader().getListMovies(listType: .popular) { result in
            switch result {
            case .succes(let movieList):
//                self.movies = movieList.results
                self.collectionView.reloadData()
            case .failure(_):
                break
            }
        }
    }
}
