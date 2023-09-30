//
//  AppImage.swift
//  Aztec
//
//  Created by Ravil on 29.09.2023.
//

import Foundation
import UIKit

protocol AppImageProtocol {
    var rawValue: String { get }
}

extension AppImageProtocol {

    var uiImage: UIImage? {
        guard let image = UIImage(named: rawValue) else {
            fatalError("Could not find image with name \(rawValue)")
        }
        return image
    }
    
    var systemImage: UIImage? {
        guard let image = UIImage(systemName: rawValue) else {
            fatalError("Could not find image with name \(rawValue)")
        }
        return image
    }
    
}

enum AppImage: String, AppImageProtocol {
    
    // MARK: - AppImage
    
    case backNavigationButton
    case coinWallet
    case background
    case backgroundAlpha
    case aztecLogo
    case splashLoading
    
    // MARK: - Main
    
    case playButton
    case fourButton
    case infoButton
    case settingsButton
    
    // MARK: - Info
    
    case rulesImage
    case infoImage
}
