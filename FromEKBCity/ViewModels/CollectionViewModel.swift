//
//  CollectionViewModel.swift
//  FromEKBCity
//
//  Created by Фаниль on 18.06.2024.
//

import UIKit

protocol CollectionViewObserver {
    func dataModelChanged()
}

class CollectionViewModel {
    
    var link = "https://it-link.ru/test/images.txt"
    var observers = [CollectionViewObserver]()
    var images: [String] = []
    
    init() {
        getImages(link: link, allLinks: false)
    }
    
    /// обсёрвер вызывается после каждого вызова getImages
    private func didChange() {
        for observer in observers {
            observer.dataModelChanged()
        }
    }
    
    /// при вызове метода устанавливаем отображение всех ссылок, или только те, которые соответствуют требованиям [images,.png,.jpg]
    func getImages(link: String, allLinks: Bool) {
        DownloadManager.shared.downloadFile(from: link, allLinks: allLinks) { [weak self] images in
            guard let self else { return }
            self.images = images
            self.didChange()
        }
    }
    
    /// возвращаем нужные размер в зависимости от ориентации устройства
    func getSizeForCell(view: UIView) -> CGSize {
        if UIDevice.current.orientation.isLandscape {
            return CGSize(width: (view.frame.width / 8) - 20, height: 87)
        } else {
            return CGSize(width: (view.frame.width / 4) - 10, height: 87)
        }
    }
}

#Preview("Main", traits: .defaultLayout, body: {
    let viewModel = CollectionViewModel()
    let viewController = CollectionViewController(viewModel: viewModel)
    return viewController
})
