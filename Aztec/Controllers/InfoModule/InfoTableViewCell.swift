//
//  InfoTableViewCell.swift
//  Aztec
//
//  Created by Ravil on 30.09.2023.
//

import UIKit
import SnapKit

final class InfoTableViewCell: UITableViewCell {

    static let reuseID = String(describing: InfoTableViewCell.self)
    
    // MARK: - UI
    
    private lazy var rulesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.rulesImage.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var infoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.infoImage.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
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
        [rulesImage, infoImage].forEach() {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        rulesImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.centerX.equalToSuperview()
        }
        infoImage.snp.makeConstraints { make in
            make.top.equalTo(rulesImage.snp.bottom).offset(42)
            make.centerX.equalToSuperview()
        }
    }
}
