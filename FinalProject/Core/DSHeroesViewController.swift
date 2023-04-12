//
//  DSHeroesViewController.swift
//  FinalProject
//
//  Created by Бекжан on 12.04.2023.
//

import UIKit
import SnapKit
final class DSHeroesViewController: UIViewController {
    
    private var heroesModelList:[DSHeroesData] = []
    private var heroes = [DSHeroesData]()
    private lazy var contentView = UIView()
    
    private lazy var searchBar:UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        return searchBar
    }()
    
    private let collectionView:UICollectionView = {
        let layot = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layot)
        collectionView.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        collectionView.layer.borderWidth = 1
        collectionView.register(DSCollectionViewCell.self, forCellWithReuseIdentifier: DSCollectionViewCell.cellIdentifier)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        APICaller.shared.fetchingAPiImages(URL: "https://api.opendota.com/api/heroStats") { result in
            self.heroes = result
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
//        APICaller.shared.fetchRequest { apiData in
//            self.heroes = apiData
//        }

        setupConstraints()
        collectionView.dataSource = self
        collectionView.delegate = self
    }

}


extension DSHeroesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DSCollectionViewCell.cellIdentifier, for: indexPath) as! DSCollectionViewCell
//        cell.configure(with: heroesModelList[indexPath.row])
        let apiData:DSHeroesData
        apiData = heroes[indexPath.row]
        let string = "https://api.opendota.com" + (apiData.img)
        let url = URL(string: string)
        cell.imageView.downloaded(from: url!, contentMode: .scaleToFill)
        cell.nameLabel.text = apiData.localized_name
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(
            width: width,
            height: width*1.2)
    }


}

private extension DSHeroesViewController {
    func setupViews(){
        view.addSubview(contentView)
        contentView.addSubview(searchBar)
        contentView.addSubview(collectionView)
    }
    func setupConstraints(){
        searchBar.snp.makeConstraints{make in
            make.top.leading.trailing.equalToSuperview()
        }
        collectionView.snp.makeConstraints{make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        contentView.snp.makeConstraints{make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)

        }
        collectionView.snp.makeConstraints{make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}



extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
