//
//  ImageViewModel.swift
//  FromEKBCity
//
//  Created by Фаниль on 19.06.2024.
//

import UIKit

class ImageViewModel {
    var image: String
    var hide: Bool = false
    
    init(image: String) {
        self.image = image
    }
    
    func hideNavBar(bar: UINavigationController) {
        hide.toggle()
        bar.setNavigationBarHidden(hide, animated: true)
    }
}
