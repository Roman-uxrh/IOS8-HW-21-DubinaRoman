//
//  ViewController.swift
//  IOS8-HW-21-DubinaRoman
//
//  Created by admin on 14.03.2023.
//

import UIKit
import SnapKit

class MainViewController: UIViewController, MainViewControllerProtocol {
    
    var presenter: MainViewPresenterProtocol?
    
    // MARK: - Outlets
    
    private lazy var imageTop: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = UIImage(named: "Marvel")
        return image
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        return collectionView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        setupHierarchy()
        setupLayout()
        configurateTabBar()
    }
    
    // MARK: - Setups
    
    private func setupHierarchy() {
        view.addSubview(collectionView)
        view.addSubview(imageTop)
    }
    
    private func setupLayout() {
        collectionView.snp.makeConstraints { make in
            make.left.bottom.right.top.equalTo(view)
        }
    }
    
    private func configurateTabBar() {
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundImage = UIImage(named: "Marvel")
        navigationController?.navigationBar.standardAppearance = standardAppearance
        
        let compactAppearance = standardAppearance.copy()
        compactAppearance.backgroundImage = UIImage(named: "Marvel")
        navigationController?.navigationBar.scrollEdgeAppearance = standardAppearance
        navigationController?.navigationBar.compactAppearance = compactAppearance
    }
    
    //MARK: - Function
    
    func reloadData() {
        collectionView.reloadData()
    }
}

// MARK: - Extension collectionView

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(
            width: view.frame.size.width / 2 - 25,
            height: view.frame.size.height / 3 - 25
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.model?.data.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell
        let charactersMarvel = presenter?.model?.data.results[indexPath.row]
        cell?.configurate(by: charactersMarvel)
        return cell ?? CollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let character = presenter?.model?.data.results[indexPath.row] else { return }
        let viewController = ModuleBuilder.createDetailView(character: character)
        collectionView.deselectItem(at: indexPath, animated: true)
        present(viewController, animated: true)
    }
}
