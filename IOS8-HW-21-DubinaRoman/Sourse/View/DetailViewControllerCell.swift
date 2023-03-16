//
//  DetailViewControllerCell.swift
//  IOS8-HW-21-DubinaRoman
//
//  Created by admin on 16.03.2023.
//

import UIKit

class DetailViewControllerCell: UIViewController {
    
    // MARK: - Outlets
    
    private lazy var idNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "name"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var imageCharacter: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        image.tintColor = .black
        image.image = UIImage(systemName: "heart")
        return image
    }()
    
    private lazy var descriptionLabel: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .center
        textView.backgroundColor = .red
        textView.font = .systemFont(ofSize: 20)
        textView.text = "descriptionLabel"
        return textView
    }()
    
    private lazy var countComic: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "comic"
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setups
    
    private func setupHierarchy() {
        [idNameLabel,
         imageCharacter,
         descriptionLabel,
         countComic,
         tableView].forEach { value in
            view.addSubview(value)
        }
    }
    
    private func setupLayout() {
        
        idNameLabel.snp.makeConstraints { make in
            make.top.equalTo(view).offset(70)
            make.left.equalTo(view).offset(40)
            make.right.equalTo(view).offset(40)
        }
        
        imageCharacter.snp.makeConstraints { make in
            make.top.equalTo(idNameLabel.snp.bottom).offset(20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(view.frame.size.height / 2)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(imageCharacter.snp.bottom).offset(20)
            make.left.equalTo(view).offset(40)
            make.right.equalTo(view).offset(-40)
            make.height.equalTo(150)
        }
        
        countComic.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.left.equalTo(view).offset(40)
            make.height.equalTo(30)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(countComic.snp.bottom)
            make.right.left.bottom.equalTo(view)
        }
    }

}

extension DetailViewControllerCell: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
