//
//  Game3x3CollectionViewCell.swift
//  Aztec
//
//  Created by Ravil on 01.10.2023.
//

import UIKit
import SnapKit

final class Game3x3CollectionViewCell: UICollectionViewCell {
    
    static let reuseID = String(describing: Game3x3CollectionViewCell.self)
    
    // MARK: - UI
    
    private lazy var cell: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.cell.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    public lazy var gameCell: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Properties

    var imageName: UIImage? {
        didSet {
            gameCell.image = imageName
        }
    }
        
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [cell, gameCell].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        cell.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        gameCell.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Configure Cell

    func configure(with imageName: String) {
        self.imageName = UIImage(named: imageName)
    }
}

