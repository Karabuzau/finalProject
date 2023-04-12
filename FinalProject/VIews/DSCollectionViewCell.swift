//
//  DSCollectionViewCell.swift
//  FinalProject
//
//  Created by Бекжан on 12.04.2023.
//

import UIKit
import SnapKit
import Kingfisher
final class DSCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "RMCharacterCollectionViewCell"
    
      lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        //imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds =  true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "antimage")
        return imageView
    }()
    
      let nameLabel:UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
//        label.text = "Anti-Mage" 
        label.font = .systemFont(ofSize: 30,weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstratins()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model:DSHeroesData){
        guard let url = URL(string: Constants.Links.baseUrl + model.img) else {return }
        DispatchQueue.main.async {
            self.imageView.kf.setImage(with: url)
        }
//        imageView.image = UIImage(named: "antimage")
        imageView.contentMode = .scaleToFill
    }
}
extension DSCollectionViewCell {
    func setupViews(){
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        
    }
    
    func setupConstratins(){
        imageView.snp.makeConstraints{make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
        }
        nameLabel.snp.makeConstraints{make in
            make.top.equalTo(imageView.snp.bottom)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
}
