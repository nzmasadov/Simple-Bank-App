//
//  UserCardsVC.swift
//  BR_Task
//
//  Created by Nazim Asadov on 30.03.24.
//

import UIKit

class UserCardsVC: UIViewController {
    
    var userCards: [CardInformation] {
        return CoreDataManager.shared.fetch(CardInformation.self)
    }
    //MARK: - UI Components
    
    private lazy var titleLbl: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.text = "My cards"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        collection.delegate = self
        collection.dataSource = self
        collection.register(UserCardsCell.self, forCellWithReuseIdentifier: String(describing: UserCardsCell.self))
        collection.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(collection)
        return collection
    }()
    
    private lazy var addBtn: UIButton = {
       let button = UIButton()
        
        button.setTitle("+", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 32)
        button.backgroundColor = UIColor.systemBlue
        button.clipsToBounds = true
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(addPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        
//        CoreDataManager.shared.fetchUserInfo { result in
//            switch result {
//            case .success(let data):
//                print("success \(data.first?.birthDate) \(data.first?.name)  \(data.first?.phoneNumber) ")
//            case .failure(let failure):
//                print("failureeee")
//            }
//        }
    }
    
    private func setupConstraints() {
        
        view.backgroundColor = .white
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            collectionView.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 50),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.heightAnchor.constraint(equalToConstant: 230),
            
            addBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            addBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addBtn.heightAnchor.constraint(equalToConstant: 60),
            addBtn.widthAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    @objc private func addPressed() {
        let vc = Router.getAddCardVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension UserCardsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UserCardsCell.self), for: indexPath) as! UserCardsCell
        
        cell.setupCell(model: userCards[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 60, height: self.collectionView.frame.height)
    }
}
