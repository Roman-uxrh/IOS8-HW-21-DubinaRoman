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
    
    lazy var photoImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        return image
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
    }
    
    private func setupLayout() {
        
        photoImage.snp.makeConstraints { make in
            make.top.right.left.bottom.equalToSuperview()
        }
    }
    
    //    override func prepareForReuse() {
    //        self.photoImage.image = nil
    //    }
}

