//
//  DetailViewControllerCell.swift
//  IOS8-HW-21-DubinaRoman
//
//  Created by admin on 16.03.2023.
//

import UIKit

class DetailViewController: UIViewController, DetailViewProtocol {
    
    var presenter: DetailViewPresenterProtocol?
    
    // MARK: - Outlets
    
    private lazy var idNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var imageCharacter: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.tintColor = .black
        return image
    }()
    
    private lazy var descriptionLabel: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .left
        textView.font = .systemFont(ofSize: 20)
        textView.backgroundColor = .systemRed
        textView.clearsOnInsertion = false
        textView.isSelectable = false
        return textView
    }()
    
    private lazy var countComic: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .black
        indicator.startAnimating()
        return indicator
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        setupHierarchy()
        setupLayout()
        configurate(by: presenter?.model)
    }
    
    // MARK: - Setups
    
    private func setupHierarchy() {
        [idNameLabel,
         imageCharacter,
         descriptionLabel,
         countComic,
         tableView,
         indicator].forEach { value in
            view.addSubview(value)
        }
    }
    
    private func setupLayout() {
        
        idNameLabel.snp.makeConstraints { make in
            make.top.equalTo(view).offset(10)
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
            make.top.equalTo(imageCharacter.snp.bottom).offset(10)
            make.left.equalTo(view).offset(40)
            make.right.equalTo(view).offset(-40)
            make.height.equalTo(100)
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
        
        indicator.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.width.height.equalTo(350)
        }
    }
    // MARK: - Functions
    
    func configurate(by model: CharacterMarvel?) {
        
        guard let model = model else { return }
        
        idNameLabel.text = "\(model.name ?? "") - id:\(model.id ?? 0)"
        if model.description == "" {
            descriptionLabel.text = "Описание персонажа отсутствует"
        } else {
            descriptionLabel.text = "Описание персонажа: -  \(model.description ?? "")"
        }
        
        countComic.text = "\(model.comics?.available ?? 0)шт - коммиксов с персонажем"
        
        DispatchQueue.global().async {
            guard let imagePath = model.thumbnail?.path,
                  let imageFormat = model.thumbnail?.format,
                  let imageUrl = URL(string: "\(imagePath).\(imageFormat)"),
                  let imageData = try? Data(contentsOf: imageUrl)
            else { return }
            
            let image = UIImage(data: imageData)
            
            DispatchQueue.main.sync {
                if imagePath.contains("image_not_available") {
                    self.imageCharacter.image = UIImage(named: "notPhoto")
                    self.indicator.stopAnimating()
                } else {
                    self.imageCharacter.image = image
                    self.indicator.stopAnimating()
                }
            }
        }
    }

}
// MARK: - Extension tableView

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.model.comics?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = presenter?.model.comics?.items?[indexPath.row].name
        cell.backgroundColor = .systemRed
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
