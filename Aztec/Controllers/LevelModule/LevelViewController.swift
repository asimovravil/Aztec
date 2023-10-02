//
//  LevelViewController.swift
//  Aztec
//
//  Created by Ravil on 01.10.2023.
//

import UIKit
import SnapKit

final class LevelViewController: UIViewController {

    let sections: [SectionType] = [.main]
    private var selectedLevel: Int?
    
    // MARK: - UI
    
    private lazy var backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.background.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var backgroundAlphaView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.backgroundAlpha.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isHidden = true
        return imageView
    }()
    
    private lazy var wrongLabel: UILabel = {
        let label = UILabel()
        label.text = "Sorry you don’t have enough Money to buy this level"
        label.textColor = AppColor.whiteCustom.uiColor
        label.font = UIFont(name: "Poppins-Bold", size: 32)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private lazy var wrongButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.buttonOK.uiImage, for: .normal)
        button.addTarget(self, action: #selector(wrongButtonTapped), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    private lazy var levelsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.levelsImage.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var mainCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(LevelCollectionViewCell.self, forCellWithReuseIdentifier: LevelCollectionViewCell.reuseID)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.isUserInteractionEnabled = true
        return collectionView
    }()
    
    private lazy var backNavigationButton: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.backNavigationButton.uiImage
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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        setupNavigationBar()
    }

    // MARK: - setupViews
    
    private func setupViews() {
        [backgroundView, levelsImage, mainCollectionView, coinWalletStackView, backNavigationButton].forEach {
            view.addSubview($0)
        }
        view.addSubview(backgroundAlphaView)
        view.addSubview(wrongLabel)
        view.addSubview(wrongButton)
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backgroundAlphaView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        wrongLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(300)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.centerX.equalToSuperview()
        }
        wrongButton.snp.makeConstraints { make in
            make.top.equalTo(wrongLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        levelsImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }
        mainCollectionView.snp.makeConstraints { make in
            make.top.equalTo(levelsImage.snp.bottom).offset(24)
            make.leading.trailing.bottom.equalToSuperview()
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
    
    // MARK: - createLayout
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            let section = self?.sections[sectionIndex] ?? .main
            switch section {
            case .main:
                return self?.mainSectionLayout()
            }
        }
    }
    
    // MARK: - Actions
    
    @objc private func wrongButtonTapped() {
        mainCollectionView.isUserInteractionEnabled = true
        self.backgroundAlphaView.isHidden = true
        self.wrongLabel.isHidden = true
        self.wrongButton.isHidden = true
    }
    
    // MARK: - sectionLayout
    
    private func mainSectionLayout() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/3), // Один из трех элементов в строке
            heightDimension: .absolute(90)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.trailing = 24 // Расстояние между элементами
        
        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(90)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item, item, item]
        )
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 24 // Расстояние между группами (строками)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 24,
            bottom: 10,
            trailing: 0
        )
        section.boundarySupplementaryItems = [supplementaryHeaderItem()]
        return section
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(43)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
    }
}

extension LevelViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .main:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: LevelCollectionViewCell.reuseID,
                for: indexPath
            ) as? LevelCollectionViewCell else {
                fatalError("Could not cast to LevelCollectionViewCell")
            }
            let levelIndex = indexPath.row + 1
            
            if levelIndex >= 1 && levelIndex <= 7 {
                let imageName = "level\(levelIndex)"
                cell.levelButton.setBackgroundImage(nil, for: .normal)
                cell.levelCloseButton.isHidden = true
                if let image = AppImage(rawValue: imageName)?.uiImage {
                    cell.levelButton.setBackgroundImage(image, for: .normal)
                }
            } else if levelIndex >= 8 {
                var imageName: String?
                switch levelIndex {
                case 8: imageName = "closeLevel100"
                case 9: imageName = "closeLevel150"
                case 10: imageName = "closeLevel200"
                case 11: imageName = "closeLevel300"
                case 12: imageName = "closeLevel500"
                case 13: imageName = "closeLevel600"
                case 14: imageName = "closeLevel700"
                case 15: imageName = "closeLevel800"
                default: break
                }
                
                if let imageName = imageName, let image = AppImage(rawValue: imageName)?.uiImage {
                    cell.levelButton.setBackgroundImage(image, for: .normal)
                }
            } else {
                cell.levelButton.setBackgroundImage(nil, for: .normal)
            }
            
            cell.levelButtonTappedHandler = {
                let controller = Game3x3ViewController()
                self.navigationController?.pushViewController(controller, animated: true)
            }
            cell.levelCloseButtonTappedHandler = {
                self.backgroundAlphaView.isHidden = false
                self.wrongLabel.isHidden = false
                self.wrongButton.isHidden = false
                collectionView.isUserInteractionEnabled = false
            }
            return cell
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
        case .main:
            return 16
        }
    }
}
