//
//  WinViewController.swift
//  Aztec
//
//  Created by Ravil on 02.10.2023.
//

import UIKit
import SnapKit

final class WinViewController: UIViewController {

    // MARK: - UI
    
    private lazy var backgroundWinView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.winBackground.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var homeButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.buttonHome.uiImage, for: .normal)
        button.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var arrowRightButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.buttonArrowRight.uiImage, for: .normal)
        button.addTarget(self, action: #selector(arrowRightButtonTapped), for: .touchUpInside)
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
        [backgroundWinView, homeButton, arrowRightButton].forEach() {
            view.addSubview($0)
        }
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        backgroundWinView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        homeButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(90)
            make.bottom.equalToSuperview().offset(-130)
        }
        arrowRightButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-90)
            make.bottom.equalToSuperview().offset(-130)
        }
    }
    
    // MARK: - Actions
    
    @objc private func homeButtonTapped() {
        let controller = MainViewController()
        controller.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func arrowRightButtonTapped() {
        let controller = LevelViewController()
        controller.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

