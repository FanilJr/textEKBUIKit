//
//  CollectionViewCell.swift
//  FromEKBCity
//
//  Created by Фаниль on 18.06.2024.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    let imageView: CustomImageView = {
        let image = CustomImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        clipsToBounds = true
        layer.cornerRadius = 20
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupImage(imageString: String) {
        imageView.loadImage(urlString: imageString)
    }
}


#Preview("Main", traits: .defaultLayout, body: {
    let viewModel = CollectionViewModel()
    let viewController = CollectionViewController(viewModel: viewModel)
    return viewController
})
