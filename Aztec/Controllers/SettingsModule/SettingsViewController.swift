//
//  SettingsViewController.swift
//  Aztec
//
//  Created by Ravil on 30.09.2023.
//

import UIKit
import SnapKit

final class SettingsViewController: UIViewController {

    private var isVibratorActive = false
    
    // MARK: - UI
    
    private lazy var backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.background.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var coinWalletImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.soloCoin.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    public lazy var coinWalletStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [coinWalletLabel, coinWalletImage])
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var coinWalletLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: "Poppins-Bold", size: 24)
        label.textColor = AppColor.whiteCustom.uiColor
        return label
    }()
    
    private lazy var switchNotification: UISwitch = {
        let switchBar = UISwitch()
        switchBar.addTarget(self, action: #selector(notificationButtonTapped), for: .valueChanged)
        return switchBar
    }()
    
    private lazy var switchVibration: UISwitch = {
        let switchBar = UISwitch()
        switchBar.addTarget(self, action: #selector(vibratorButtonTapped), for: .valueChanged)
        return switchBar
    }()
    
    private lazy var settingsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.settingsImage.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var notificationView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.notification.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var vibrationView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.vibration.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var rateUsButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.rateUs.uiImage, for: .normal)
        button.addTarget(self, action: #selector(rateUsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareAppButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.shareApp.uiImage, for: .normal)
        button.addTarget(self, action: #selector(shareAppButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var privacyPolicyButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.privacyPolicy.uiImage, for: .normal)
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
        [backgroundView, coinWalletStackView, switchNotification,  switchVibration, settingsImage, notificationView, vibrationView, shareAppButton, rateUsButton, privacyPolicyButton].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        settingsImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }
        switchNotification.snp.makeConstraints { make in
            make.top.equalTo(notificationView.snp.top).offset(20)
            make.trailing.equalTo(notificationView.snp.trailing).offset(-24)
        }
        switchVibration.snp.makeConstraints { make in
            make.top.equalTo(vibrationView.snp.top).offset(20)
            make.trailing.equalTo(vibrationView.snp.trailing).offset(-24)
        }
        notificationView.snp.makeConstraints { make in
            make.top.equalTo(settingsImage.snp.bottom).offset(42)
            make.centerX.equalToSuperview()
            make.height.equalTo(68)
        }
        vibrationView.snp.makeConstraints { make in
            make.top.equalTo(notificationView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.height.equalTo(68)
        }
        rateUsButton.snp.makeConstraints { make in
            make.top.equalTo(vibrationView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.height.equalTo(68)
        }
        shareAppButton.snp.makeConstraints { make in
            make.top.equalTo(rateUsButton.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.height.equalTo(68)
        }
        privacyPolicyButton.snp.makeConstraints { make in
            make.top.equalTo(shareAppButton.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.height.equalTo(68)
        }
    }
    
    // MARK: - setupNavigationBar
    
    private func setupNavigationBar() {
        let backButton = UIBarButtonItem(image: AppImage.backNavigationButton.uiImage, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        let coinWalletBarButtonItem = UIBarButtonItem(customView: coinWalletStackView)
        navigationItem.rightBarButtonItem = coinWalletBarButtonItem
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - notificationButtonTapped
    
    @objc private func notificationButtonTapped() {
        if switchNotification.isOn {
            print("Notification On")
        } else {
            print("Notification Off")
        }
    }
    
    // MARK: - vibratorButtonTapped
    
    @objc private func vibratorButtonTapped() {
        if switchVibration.isOn {
            turnOnVibration()
        } else {
            turnOffVibration()
        }
    }
    
    private func turnOnVibration() {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred()
    }
    
    private func turnOffVibration() {
        print("turn off vibration")
    }
    
    // MARK: - shareAppButtonTapped
    
    @objc private func shareAppButtonTapped() {
        let actionSheet = UIAlertController(title: nil, message: "Share App", preferredStyle: .actionSheet)
        let messageAction = UIAlertAction(title: "Share via Message", style: .default) { [weak self] _ in
            self?.shareAppViaMessage()
        }

        let otherAppsAction = UIAlertAction(title: "Share via Other Apps", style: .default) { [weak self] _ in
            self?.shareAppViaOtherApps()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        actionSheet.addAction(messageAction)
        actionSheet.addAction(otherAppsAction)
        actionSheet.addAction(cancelAction)

        present(actionSheet, animated: true, completion: nil)
    }
    
    private func shareAppViaMessage() {
    }

    private func shareAppViaOtherApps() {
        let textToShare = "Check out this awesome app!"
        let appURL = URL(string: "https://www.yourappstorelink.com")!

        let activityViewController = UIActivityViewController(activityItems: [textToShare, appURL], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    // MARK: - rateUsButtonTapped
    
    @objc private func rateUsButtonTapped() {
        let appName = "Moony Journey"

        if let url = URL(string: "https://itunes.apple.com/search?term=\(appName)&entity=software") {
            let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let results = json["results"] as? [[String: Any]],
                           let firstResult = results.first,
                           let appID = firstResult["trackId"] as? Int {
                            self.openAppStorePage(for: appID)
                        }
                    } catch {
                        print("JSON parsing error: \(error.localizedDescription)")
                    }
                }
            }
            task.resume()
        }
    }

    private func openAppStorePage(for appID: Int) {
        let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id\(appID)?action=write-review")!

        if UIApplication.shared.canOpenURL(appStoreURL) {
            UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
        } else {
            print("Unable to open App Store URL")
        }
    }
    
}
