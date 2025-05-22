//
//  UIFont+Ext.swift
//  Wallet
//
//  Created by Дарья Шишмакова on 22.05.2025.
//

import UIKit

extension UIFont {
    
    static func poppinsMedium(ofSize size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Poppins-Medium", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: .medium)
        }
        return font
    }
    
    static func poppinsRegular(ofSize size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Poppins-Regular", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: .regular)
        }
        return font
    }
    
    static func poppinsSemiBold(ofSize size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Poppins-SemiBold", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: .semibold)
        }
        return font
    }
}
