//
//  MainTableViewCell.swift
//  Aztec
//
//  Created by Ravil on 30.09.2023.
//

import UIKit
import SnapKit

final class MainTableViewCell: UITableViewCell {

    static let reuseID = String(describing: MainTableViewCell.self)
    var playButtonTappedHandler: (() -> Void)?
    var infoButtonTappedHandler: (() -> Void)?
    var settingsButtonTappedHandler: (() -> Void)?
    var fourButtonTappedHandler: (() -> Void)?


    // MARK: - UI
    
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
        button.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var fourButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.fourButton.uiImage, for: .normal)
        button.addTarget(self, action: #selector(fourButtonTapped), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [aztecLogoImage, playButton, fourButton, infoButton, settingsButton].forEach() {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
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
    
    // MARK: - Actions
    
    @objc private func playButtonTapped() {
        playButtonTappedHandler?()
    }
    
    @objc private func fourButtonTapped() {
        fourButtonTappedHandler?()
    }
    
    @objc private func infoButtonTapped() {
        infoButtonTappedHandler?()
    }
    
    @objc private func settingsButtonTapped() {
        settingsButtonTappedHandler?()
    }
}
