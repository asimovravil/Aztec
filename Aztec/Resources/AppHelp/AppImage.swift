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
    
    case cell
    case backNavigationButton
    case coinWallet
    case background
    case backgroundAlpha
    case aztecLogo
    case buttonOK
    case splashLoading
    
    // MARK: - Main
    
    case playButton
    case fourButton
    case infoButton
    case settingsButton
    
    // MARK: - Info
    
    case rulesImage
    case infoImage
    
    // MARK: - Settings
    
    case settingsImage
    case notification
    case vibration
    case rateUs
    case shareApp
    case privacyPolicy
    
    // MARK: - Levels
    
    case levelsImage
    case level1
    case level2
    case level3
    case level4
    case level5
    case level6
    case level7
    
    case closeLevel100
    case closeLevel150
    case closeLevel200
    case closeLevel300
    case closeLevel500
    case closeLevel600
    case closeLevel700
    case closeLevel800
    
    // MARK: - Game
    
    case cellGame1
    case cellGame2
    case cellGame3
    case cellGame4
    case cellGame5
    case cellGame6
    case cellGame7
    case cellGame8
    case levelGame
    case legsLevel
    case buttonLevel
    
    // MARK: - BonusGame
    
    case happyStolb
    case angryStolb
    case bonusLogo
    case fallLogo
    case oldCoin
    case tiredCoin
    case tiredCoinButton
    case oldCoinButton
    case youWrong
    case youWin
}
