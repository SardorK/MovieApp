//
//  PopularViewController.swift
//  MovieAPI
//
//  Created by User 2 on 11/08/22.
//

import UIKit

class PopularViewController: UIViewController{
    
    var movies : [Movie] = []
    
    lazy var backGroundImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        
        return view
    }()
    
    lazy var popularLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Popular"
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 40.0, weight: .bold)
        view.textColor = .white
        
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(PopularCollectionViewCell.self, forCellWithReuseIdentifier: "PopularCollectionViewCell")
        view.dataSource = self
        view.delegate = self
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSubviews()
        view.backgroundColor = .white
        title = "Top Rated"
    }
    
    func createLayout()-> UICollectionViewCompositionalLayout{
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)))
        item.contentInsets.trailing = 5.0
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3)), subitems: [item])
        group.contentInsets.bottom = 5.0
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
        
    }
    
    func setUpSubviews(){
        
        view.addSubview(collectionView)
        view.addSubview(backGroundImage)
        view.addSubview(popularLabel)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200.0),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10.0),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10.0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10.0),
            
            backGroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backGroundImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            backGroundImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            backGroundImage.bottomAnchor.constraint(equalTo: collectionView.topAnchor,constant: -20.0),
            
            popularLabel.topAnchor.constraint(equalTo: view.topAnchor,constant: 20.0),
            popularLabel.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20.0),
            popularLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20.0),
            popularLabel.bottomAnchor.constraint(equalTo: backGroundImage.bottomAnchor)
        ])
        PopularListMovieLoader().getListMovies(listType: .popular) { result in
            switch result {
            case .succes(let movieList):
                self.movies = movieList.results
                self.collectionView.reloadData()
            case .failure(_):
                break
            }
        }
    }
}

extension PopularViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCollectionViewCell", for: indexPath) as? PopularCollectionViewCell else{
            return UICollectionViewCell()
        }
        let movie = movies[indexPath.row]
        cell.nameLabel.text = "\(String(describing: movie.originalTitle))"
        cell.filmImage.loadFrom(URLAddress: "https://image.tmdb.org/t/p/w500" + "\(movie.posterPath)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = FilmInfo()
        let movie = movies[indexPath.row]
        vc.movies = movie
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true)
    }
    
    
    
}

extension UIImageView{
    func loadFrom (URLAddress: String){
            guard let url = URL(string: URLAddress) else {
                    return
            }
            DispatchQueue.main.async { [weak self] in
                if let imageData = try? Data(contentsOf: url){
                            if let loadedImage = UIImage (data: imageData) {
                                    self?.image = loadedImage
                }
            }
        }
    }
}

