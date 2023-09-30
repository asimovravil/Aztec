//
//  SplashViewController.swift
//  Aztec
//
//  Created by Ravil on 29.09.2023.
//

import UIKit
import SnapKit

final class SplashViewController: UIViewController {
    
    private lazy var backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.background.uiImage
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
    
    private lazy var splashLoadingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.splashLoading.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var splashLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.font = UIFont(name: "Poppins-Medium", size: 32)
        label.textColor = AppColor.whiteCustom.uiColor
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [backgroundView, aztecLogoImage, splashLoadingImage, splashLabel].forEach() {
            view.addSubview($0)
        }
        startRotationAnimation()
    }

    private func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        aztecLogoImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(59)
            make.trailing.equalToSuperview().offset(-59)
        }
        splashLoadingImage.snp.makeConstraints { make in
            make.top.equalTo(aztecLogoImage.snp.bottom).offset(160)
            make.centerX.equalToSuperview()
        }
        splashLabel.snp.makeConstraints { make in
            make.top.equalTo(splashLoadingImage.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Action
    
    private func startRotationAnimation() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.repeat, .curveLinear], animations: {
            self.splashLoadingImage.transform = self.splashLoadingImage.transform.rotated(by: .pi)
        }, completion: nil)
    }
}
