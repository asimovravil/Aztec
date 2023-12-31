//
//  Game3x3ViewController.swift
//  Aztec
//
//  Created by Ravil on 01.10.2023.
//

import UIKit
import SnapKit

final class Game3x3ViewController: UIViewController {

    let sections: [SectionType] = [.main]
    var selectedCellIndex: IndexPath?
    var score: Int {
        get {
            return UserDefaults.standard.integer(forKey: "score")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "score")
            coinWalletLabel.text = "\(newValue)"
        }
    }
    
    // MARK: - UI
    
    private lazy var backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.background.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
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
    
    private lazy var mainCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(Game3x3CollectionViewCell.self, forCellWithReuseIdentifier: Game3x3CollectionViewCell.reuseID)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.isUserInteractionEnabled = true
        return collectionView
    }()
    
    private lazy var levelGameImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.levelGame.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var legsLevelImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.legsLevel.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var buttonLevelImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.buttonLevel.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        setupNavigationBar()
        coinWalletLabel.text = "\(score)"
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [backgroundView, backNavigationButton, coinWalletStackView, mainCollectionView, levelGameImage, legsLevelImage, buttonLevelImage].forEach() {
            view.addSubview($0)
        }
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        mainCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.leading.trailing.bottom.equalToSuperview()
        }
        levelGameImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(31)
            make.bottom.equalToSuperview().offset(-80)
        }
        legsLevelImage.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-75)
            make.centerX.equalToSuperview()
        }
        buttonLevelImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-60)
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

extension Game3x3ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .main:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Game3x3CollectionViewCell.reuseID,
                for: indexPath
            ) as? Game3x3CollectionViewCell else {
                fatalError("Could not cast to LevelCollectionViewCell")
            }
            switch indexPath.row {
            case 0:
                cell.configure(with: AppImage.cellGame6.rawValue)
            case 1:
                cell.configure(with: AppImage.cellGame2.rawValue)
            case 2:
                cell.configure(with: AppImage.cellGame3.rawValue)
            case 3:
                cell.configure(with: AppImage.cellGame5.rawValue)
            case 4:
                cell.configure(with: AppImage.cellGame7.rawValue)
            case 5:
                cell.configure(with: AppImage.cellGame4.rawValue)
            case 6:
                cell.configure(with: AppImage.cellGame8.rawValue)
            case 7:
                cell.configure(with: AppImage.cellGame1.rawValue)
            default:
                cell.imageName = nil
            }
            return cell
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
        case .main:
            return 9
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedCellIndex = selectedCellIndex else {
            let selectedCell = collectionView.cellForItem(at: indexPath) as! Game3x3CollectionViewCell
            if selectedCell.imageName != nil { 
                self.selectedCellIndex = indexPath
            }
            return
        }
        
        let secondCell = collectionView.cellForItem(at: indexPath) as! Game3x3CollectionViewCell
        if secondCell.imageName == nil {
            let firstCell = collectionView.cellForItem(at: selectedCellIndex) as! Game3x3CollectionViewCell
            
            let tempImage = firstCell.imageName
            firstCell.imageName = secondCell.imageName
            secondCell.imageName = tempImage
            
            self.selectedCellIndex = nil
            checkIfPuzzleCompleted()
        }
    }
    
    private func checkIfPuzzleCompleted() {
        let correctOrder: [AppImage] = [
            .cellGame1,
            .cellGame2,
            .cellGame3,
            .cellGame4,
            .cellGame5,
            .cellGame6,
            .cellGame7,
            .cellGame8
        ]
        
        for (index, image) in correctOrder.enumerated() {
            let cell = mainCollectionView.cellForItem(at: IndexPath(item: index, section: 0)) as! Game3x3CollectionViewCell
            if cell.imageName != image.uiImage {
                return
            }
        }
        
        score += 20 
        
        let controller = BonusGameViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

    


