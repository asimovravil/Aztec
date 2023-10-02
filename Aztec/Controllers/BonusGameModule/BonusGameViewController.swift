//
//  BonusGameViewController.swift
//  Aztec
//
//  Created by Ravil on 02.10.2023.
//

import UIKit
import SnapKit

final class BonusGameViewController: UIViewController {

    // MARK: - UI
    
    private lazy var backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.background.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var bonusView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.bonusLogo.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var fallView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.fallLogo.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var coinView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.oldCoin.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var angryStolbView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.angryStolb.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var happyStolbView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.happyStolb.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var oldCoinButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.oldCoinButton.uiImage, for: .normal)
        return button
    }()
    
    private lazy var tiredCoinButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.tiredCoinButton.uiImage, for: .normal)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [backgroundView, bonusView, fallView, coinView, angryStolbView, happyStolbView, oldCoinButton, tiredCoinButton].forEach() {
            view.addSubview($0)
        }
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        bonusView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }
        fallView.snp.makeConstraints { make in
            make.top.equalTo(bonusView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        coinView.snp.makeConstraints { make in
            make.top.equalTo(fallView.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
        }
        angryStolbView.snp.makeConstraints { make in
            make.top.equalTo(bonusView.snp.bottom).offset(60)
            make.leading.equalToSuperview().offset(-20)
        }
        happyStolbView.snp.makeConstraints { make in
            make.top.equalTo(bonusView.snp.bottom).offset(60)
            make.trailing.equalToSuperview().offset(20)
        }
        oldCoinButton.snp.makeConstraints { make in
            make.top.equalTo(coinView.snp.bottom).offset(70)
            make.leading.equalToSuperview().offset(114)
        }
        tiredCoinButton.snp.makeConstraints { make in
            make.top.equalTo(coinView.snp.bottom).offset(70)
            make.trailing.equalToSuperview().offset(-114)
        }
    }
}

