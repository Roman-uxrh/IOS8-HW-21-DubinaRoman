//
//  CollectionCell.swift
//  IOS8-HW-21-DubinaRoman
//
//  Created by admin on 14.03.2023.
//

import UIKit
import SnapKit
import Alamofire

class CollectionViewCell: UICollectionViewCell, CollectinViewCellProtocol {
    
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
    
    lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .black
        indicator.startAnimating()
        return indicator
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
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
        addSubview(indicator)
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
        
        indicator.snp.makeConstraints { make in
            make.center.equalTo(contentView)
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
                    self.indicator.stopAnimating()
                } else {
                    self.photoImage.image = image
                    self.indicator.stopAnimating()
                }
            }
        }
    }
    
    override func prepareForReuse() {
        self.photoImage.image = nil
        self.indicator.startAnimating()
    }
}

