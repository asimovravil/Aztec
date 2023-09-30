//
//  MainViewController.swift
//  Aztec
//
//  Created by Ravil on 30.09.2023.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    // MARK: - UI
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    private lazy var backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.background.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var coinWalletImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.coinWallet.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var aztecLogoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.aztecLogo.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.playButton.uiImage, for: .normal)
        return button
    }()
    
    private lazy var fourButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.fourButton.uiImage, for: .normal)
        return button
    }()
    
    private lazy var infoButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.infoButton.uiImage, for: .normal)
        button.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.settingsButton.uiImage, for: .normal)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupNavigationBar()
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [backgroundView, coinWalletImage, aztecLogoImage, playButton, fourButton, infoButton, settingsButton].forEach() {
            contentView.addSubview($0)
        }
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view)
        }
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        aztecLogoImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        playButton.snp.makeConstraints { make in
            make.top.equalTo(aztecLogoImage.snp.bottom).offset(97)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(infoButton.snp.top).offset(-70)
        }
        fourButton.snp.makeConstraints { make in
            make.top.equalTo(playButton.snp.bottom).offset(70)
            make.leading.equalToSuperview().offset(24)
        }
        infoButton.snp.makeConstraints { make in
            make.top.equalTo(playButton.snp.bottom).offset(70)
            make.centerX.equalToSuperview()
        }
        settingsButton.snp.makeConstraints { make in
            make.top.equalTo(playButton.snp.bottom).offset(70)
            make.trailing.equalToSuperview().offset(-24)
        }
    }
        
    // MARK: - setupNavigationBar
    
    private func setupNavigationBar() {
        let coinWalletBarButtonItem = UIBarButtonItem(customView: coinWalletImage)
        navigationItem.rightBarButtonItem = coinWalletBarButtonItem
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    // MARK: - Actions
    
    @objc private func infoButtonTapped() {
        let controller = InfoViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

