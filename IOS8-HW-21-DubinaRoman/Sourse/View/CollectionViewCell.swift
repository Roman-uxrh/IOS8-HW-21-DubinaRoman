//
//  CollectionCell.swift
//  IOS8-HW-21-DubinaRoman
//
//  Created by admin on 14.03.2023.
//

import UIKit
import SnapKit

class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FlowLayoutCell"
    
    private lazy var photoImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        image.image = UIImage(systemName: "person.crop.square")
        image.tintColor = .black
        return image
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Grerjkicks"
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .red
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    func configurate(by model: [AnswerMarvelService?]) {
        guard let model = model else { return }
        
        
    }
    
    
    //    override func prepareForReuse() {
    //        self.photoImage.image = nil
    //    }
}

