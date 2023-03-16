//
//  ViewController.swift
//  IOS8-HW-21-DubinaRoman
//
//  Created by admin on 14.03.2023.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    let networkingService = NetworkingService()
    
    var model: AnswerMarvelService?
    
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
//        navigationController?.navigationBar.backgroundImage = UIImage(systemName: "arrowshape.turn.up.backward.circle")
//        navigationController?.navigationBar.set
        view.backgroundColor = .white
        setupHierarchy()
        setupLayout()
        networkingService.getData(url: networkingService.createUrlMarvel()) { result in
            switch result {
                case .success(let success):
                    self.model = success
                    self.collectionView.reloadData()
                case .failure(let failure):
                    print(failure)
            }
        }
        
    }
    
    // MARK: - Setups
    
    private func setupHierarchy() {
        view.addSubview(collectionView)
        view.addSubview(imageTop)
    }
    
    private func setupLayout() {
        
//        imageTop.snp.makeConstraints { make in
//            make.top.
//        }
        
        collectionView.snp.makeConstraints { make in
            make.left.bottom.right.top.equalTo(view)
        }
        
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
        model?.data.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell
        let charactersMarvel = model?.data.results[indexPath.row]
        cell?.configurate(by: charactersMarvel)
        return cell ?? CollectionViewCell()
    }
}
