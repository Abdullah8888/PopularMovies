//
//  PopularMovieDetailView.swift
//  PopularMovies
//
//  Created by Abdullah on 17/09/2022.
//

import Foundation
import UIKit

class PopularMovieDetailView: BaseView {
    
    let posterImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.backgroundColor = .systemRed
        img.clipsToBounds = true
        img.constrainHeight(constant: 210)
        img.cornerRadius = 7
        return img
    }()
    
    let titleLabel: Label = {
        let label = Label(text: "Title", font: .helveticaNeueBold(size: 17), textColor: .systemRed, alignment: .center)
        return label
    }()
    
    let overViewLabel: Label = {
        let label = Label(text: "Overview", font: .helveticaNeueRegular(size: 15), textColor: .systemRed.withAlphaComponent(0.8))
        return label
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [posterImage,titleLabel,overViewLabel])
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis  = .vertical
        return stackView
    }()
    
    override func setup() {
        super.setup()
        backgroundColor = .black
        addSubview(verticalStackView)
        verticalStackView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, trailing: trailingAnchor, margin: .init(top: 20, left: 20, bottom: 0, right: 20))
    }
}

