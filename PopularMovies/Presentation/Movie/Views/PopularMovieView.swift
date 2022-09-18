//
//  PopularMovieView.swift
//  PopularMovies
//
//  Created by Abdullah on 17/09/2022.
//

import Foundation
import UIKit

class PopularMovieView: BaseView {
    
    let movieCell = String(describing: MovieCell.self)
    lazy var movieCollectionView: UICollectionView = {
        //let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let layout: MovieFlowLayout = MovieFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: movieCell)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .black
        collectionView.collectionViewLayout = layout
        collectionView.contentInsetAdjustmentBehavior = .always
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: ((frame.width-20)/2)-20, height: 0)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
//        commentFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        commentFlowLayout.minimumInteritemSpacing = 10
//        commentFlowLayout.minimumLineSpacing = 10
//        commentCollection.collectionViewLayout = commentFlowLayout
//        commentCollection.contentInsetAdjustmentBehavior = .always
        return collectionView
    }()
    
    var movieFlowCoordinator: MovieFlowCoordinator?
    
    override func setup() {
        super.setup()
        addSubviews(movieCollectionView)
        movieCollectionView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, margin: .init(top: 20, left: 10, bottom: 20, right: 10))
    }
}

extension PopularMovieView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCell, for: indexPath) as! MovieCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("I'm tapped")
        movieFlowCoordinator?.showMovieDetails(movieId: 1)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        CGSize(width: ((frame.width-20)/2)-20, height: 0)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        20
//    }
//
////    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
////        0
////    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        .init(top: 0, left: 0, bottom: 0, right: 0)
//    }

}


class MovieCell: BaseCollectionViewCell {
    
    let posterImage: UIImageView = {
        let img = UIImageView()
        img.changeImageColor(to: .red)
        img.contentMode = .scaleAspectFit
        img.backgroundColor = .systemRed
        img.constrainHeight(constant: 250)
        return img
    }()
    
    let titleLabel: Label = {
        let label = Label(text: "Title", font: .helveticaNeueBold(size: 17), textColor: .systemRed, alignment: .center)
        return label
    }()
    
    let overViewLabel: Label = {
        let label = Label(text: "Overview", font: .helveticaNeueRegular(size: 15), numberOfLines: 3, textColor: .systemRed.withAlphaComponent(0.8), alignment: .center)
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
    
    override func setup() {
        super.setup()
        contentView.addSubview(containerView)
        backgroundColor = .black
        containerView.fillUpSuperview(margin: .init(allEdges: 20))
        containerView.addSubview(stackView)
        stackView.fillUpSuperview(margin: .init(allEdges: 20))
    }
    
//    func updateCell(with movie: Movie) {
//        titleLabel.text = movie.title ?? "Not Found"
//        overViewLabel.text = movie.overview ?? "Not Found"
//        let ff = .posterHost + (movie.posterPath ?? "")
//        print("the img full url is \(ff)")
//        posterImage.showImage(url: .posterHost + (movie.posterPath ?? ""))
//    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize,withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return layoutAttributes
    }
}
