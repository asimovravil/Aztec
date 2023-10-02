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
        imageView.isHidden = false
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
    
    private lazy var firstAnswerButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.oldCoinButton.uiImage, for: .normal)
        button.addTarget(self, action: #selector(firstAnswerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var secondAnswerButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.tiredCoinButton.uiImage, for: .normal)
        button.addTarget(self, action: #selector(secondAnswerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var correctImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.youWin.uiImage
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()
    
    private lazy var wrongImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.youWrong.uiImage
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [backgroundView, bonusView, fallView, coinView, angryStolbView, happyStolbView, firstAnswerButton, secondAnswerButton, correctImageView, wrongImageView].forEach() {
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
        correctImageView.snp.makeConstraints { make in
            make.top.equalTo(bonusView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        wrongImageView.snp.makeConstraints { make in
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
        firstAnswerButton.snp.makeConstraints { make in
            make.top.equalTo(coinView.snp.bottom).offset(70)
            make.leading.equalToSuperview().offset(114)
        }
        secondAnswerButton.snp.makeConstraints { make in
            make.top.equalTo(coinView.snp.bottom).offset(70)
            make.trailing.equalToSuperview().offset(-114)
        }
    }
    
    // MARK: - Actions
    
    @objc private func firstAnswerButtonTapped() {
        UIView.transition(with: correctImageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.correctImageView.isHidden = false
        }, completion: nil)
        secondAnswerButton.isEnabled = false
        fallView.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let controller = WinViewController()
            controller.navigationItem.hidesBackButton = true
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    @objc private func secondAnswerButtonTapped() {
        UIView.transition(with: wrongImageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.wrongImageView.isHidden = false
        }, completion: nil)
        firstAnswerButton.isEnabled = false
        fallView.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let controller = WinViewController()
            controller.navigationItem.hidesBackButton = true
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

