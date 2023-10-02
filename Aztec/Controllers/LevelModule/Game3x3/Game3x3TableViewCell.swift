//
//  Game3x3TableViewCell.swift
//  Aztec
//
//  Created by Ravil on 01.10.2023.
//

import UIKit
import SnapKit

final class Game3x3TableViewCell: UITableViewCell {

    static let reuseID = String(describing: Game3x3TableViewCell.self)
    
    // MARK: - UI
    
    private lazy var cell: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.cell.uiImage
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
        [cell].forEach() {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        cell.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.centerX.equalToSuperview()
        }
    }
}
