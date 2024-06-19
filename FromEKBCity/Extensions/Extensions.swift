//
//  Extensions.swift
//  FromEKBCity
//
//  Created by Фаниль on 18.06.2024.
//

import UIKit

extension UIColor {
    static func createColor(light: UIColor, dark: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else { return light }
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .dark ? dark : light }
    }
}
