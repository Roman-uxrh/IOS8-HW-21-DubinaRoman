//
//  CollectionCell.swift
//  IOS8-HW-21-DubinaRoman
//
//  Created by admin on 14.03.2023.
//

import UIKit
import SnapKit
import Alamofire

class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FlowLayoutCell"
    
    // MARK: - Outlets
    
    lazy var photoImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        image.tintColor = .black
        return image
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .red
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setups
    
    private func setupHierarchy() {
        addSubview(photoImage)
        addSubview(title)
    }
    
    private func setupLayout() {
        
        photoImage.snp.makeConstraints { make in
            make.right.left.equalToSuperview()
            make.top.equalTo(title.snp.bottom)
            make.bottom.equalTo(contentView)
        }
        
        title.snp.makeConstraints { make in
            make.right.left.top.equalTo(contentView)
            make.height.equalTo(20)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Function
    
    func configurate(by model: CharacterMarvel?) {
        
        guard let model = model else { return }
        
        title.text = model.name
        
        DispatchQueue.global().async {
            guard let imagePath = model.thumbnail?.path,
                  let imageFormat = model.thumbnail?.format,
                  let imageUrl = URL(string: "\(imagePath).\(imageFormat)"),
                  let imageData = try? Data(contentsOf: imageUrl)
            else { return }
            
            let image = UIImage(data: imageData)
            
            DispatchQueue.main.sync {
                if imagePath.contains("image_not_available") {
                    self.photoImage.image = UIImage(named: "notPhoto")
                } else {
                    self.photoImage.image = image
                }
            }
        }
    }
    
    override func prepareForReuse() {
        self.photoImage.image = nil
    }
}

