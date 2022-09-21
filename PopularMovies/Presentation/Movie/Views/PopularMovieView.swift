//
//  PopularMovieView.swift
//  PopularMovies
//
//  Created by Abdullah on 17/09/2022.
//

import Foundation
import UIKit
import Cosmos

class PopularMovieView: BaseView {
    
    let movieCell = String(describing: MovieCell.self)
    lazy var movieCollectionView: UICollectionView = {
        //let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let layout: MovieFlowLayout = MovieFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: movieCell)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .black
        collectionView.collectionViewLayout = layout
        collectionView.contentInsetAdjustmentBehavior = .always
        layout.delegate = self
        return collectionView
    }()
    
    var movieFlowCoordinator: MovieFlowCoordinator?
    var alertHandler: ((String) ->())?
    var movies: [Movie]? {
        didSet {
            if movies?.isEmpty ?? false {
                movieCollectionView.showEmptyViewWith(text: "No data found")
            }
            else {
                movieCollectionView.reloadData()
            }
        }
    }
    override func setup() {
        super.setup()
        addSubview(movieCollectionView)
        movieCollectionView.fillUpSuperview()
    }
}


extension PopularMovieView: MovieFlowLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, cellWidth: CGFloat) -> CGFloat {
        let titleHeight = calcLabelHeight(text: movies?[indexPath.row].title ?? "", cellWidth: cellWidth)
        let overViewHeight = calcLabelHeight(text: movies?[indexPath.row].overview ?? "", cellWidth: cellWidth, textFont: .helveticaNeueRegular(size: 15), numberOfLines: 3, lineBreakMode: .byTruncatingTail)
        return 210 + 10 + titleHeight + 40 + overViewHeight + 30
    }
}

extension PopularMovieView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCell, for: indexPath) as! MovieCell
        if let movie = movies?[indexPath.row] {
            cell.updateCell(with: movie)
        }
        cell.posterImage.onClick(completion: weakify({ strongSelf in
            strongSelf.alertHandler?(strongSelf.movies?[indexPath.row].title ?? "")
        }))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movieId = movies?[indexPath.row].id else {return}
        movieFlowCoordinator?.showMovieDetails(movieId: Int(movieId))
    }
    
    func calcLabelHeight(text:String , cellWidth : CGFloat, textFont: UIFont = .helveticaNeueBold(size: 17), numberOfLines: Int = 0, lineBreakMode: NSLineBreakMode = .byWordWrapping) -> CGFloat {
        let font = textFont
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: cellWidth, height: .greatestFiniteMagnitude))
        label.numberOfLines = numberOfLines
        label.lineBreakMode = lineBreakMode
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }

}


class MovieCell: BaseCollectionViewCell {
    
    let posterImage: UIImageView = {
        let img = UIImageView()
        //img.changeImageColor(to: .red)
        img.contentMode = .scaleAspectFit
        img.backgroundColor = .systemRed
        img.clipsToBounds = true
        //img.constrainHeight(constant: 250)
        img.cornerRadius = 7
        return img
    }()
    
    let titleLabel: Label = {
        let label = Label(text: "Title", font: .helveticaNeueBold(size: 17), textColor: .systemRed, alignment: .center)
        return label
    }()
    
    let overViewLabel: Label = {
        let label = Label(text: "Overview", font: .helveticaNeueRegular(size: 15), numberOfLines: 3, textColor: .systemRed.withAlphaComponent(0.8), lineBreakMode: .byTruncatingTail)
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [posterImage,titleLabel,overViewLabel])
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.layer.borderWidth = 1
        stackView.clipsToBounds = true
        return stackView
    }()
    
    let containerView: ShadowView = {
        let view = ShadowView()
        view.backgroundColor = .black
        return view
    }()
    
    let cosmosView: CosmosView = {
        let view = CosmosView.init()
        view.settings.updateOnTouch = false
        view.settings.fillMode = .full
        view.settings.starSize = 20
        view.settings.starMargin = 5
        view.settings.filledColor = UIColor.orange
        view.settings.emptyBorderColor = UIColor.orange
        view.settings.filledBorderColor = UIColor.orange
        return view
    }()
    
    override func setup() {
        super.setup()
        contentView.addSubview(containerView)
        backgroundColor = .black

        containerView.fillUpSuperview()
        containerView.addSubviews(posterImage, titleLabel, cosmosView, overViewLabel)
        posterImage.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, size: .init(width: 0, height: 210))
        
        titleLabel.anchor(top: posterImage.bottomAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, margin: .init(top: 10, left: 5, bottom: 0, right: 5))
        
        cosmosView.anchor(top: titleLabel.bottomAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, margin: .init(top: 10, left: 7, bottom: 0, right: 0), size: .init(width: Constant.screenWidth/2, height: 20))
        
        overViewLabel.anchor(top: cosmosView.bottomAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, margin: .init(top: 10, left: 7, bottom: 5, right: 7))
    }
    
    func updateCell(with movie: Movie) {
        titleLabel.text = movie.title ?? "Not Found"
        overViewLabel.text = movie.overview ?? "Not Found"
        posterImage.showImage(url: .posterHost + (movie.posterPath ?? ""))
        guard let rating = movie.voteAverage else {
            cosmosView.rating = 0
            return
        }
        cosmosView.rating = rating > 8.0 ? rating : 0
    }

}
