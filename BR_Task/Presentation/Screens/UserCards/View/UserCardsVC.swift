//
//  UserCardsVC.swift
//  BR_Task
//
//  Created by Nazim Asadov on 30.03.24.
//

import UIKit

class UserCardsVC: UIViewController {
    
    var userCards: [CardInfoEntity] {
        return CoreDataManager.shared.fetchData(CardInfoEntity.self)
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
        setupLongGestureRecognizerOnCollection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        collectionView.reloadData()
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
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}

extension UserCardsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UserCardsCell.self), for: indexPath) as! UserCardsCell
        cell.delegate = self
        cell.setupCell(model: userCards[indexPath.row], index: indexPath.row)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 60, height: self.collectionView.frame.height)
    }
    
    
}

extension UserCardsVC: UIGestureRecognizerDelegate {
    private func setupLongGestureRecognizerOnCollection() {
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        longPressedGesture.minimumPressDuration = 0.5
        longPressedGesture.delegate = self
        longPressedGesture.delaysTouchesBegan = true
        collectionView.addGestureRecognizer(longPressedGesture)
    }
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if (gestureRecognizer.state != .began) {
            return
        }

        let p = gestureRecognizer.location(in: collectionView)
        if let indexPath = collectionView.indexPathForItem(at: p) {
            
            showMultipleAlert(with: "Are you sure to delete?", preferredStyle: .alert, actions: [(title: "Cancel", style: .cancel), (title: "Delete", style: .destructive)]) { (index, _) in
                if index == 1 {
                    self.deleteCard(with: indexPath.row)
                }else {
                    return
                }
            }
        }
    }
    
    private func deleteCard(with index: Int) {
        let coreManager = CoreDataManager.shared
        coreManager.deleteCard(card: userCards[index]) { [weak self] success in
            guard let self else {return}
            switch success {
            case .success:
                if userCards.isEmpty {
                    let vc = BaseNavigationViewController(rootViewController: Router.getRegisterVC())
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                }else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:  {
                        self.collectionView.reloadData()
                    })
                }

            case .failure:
                print("Error")
            }
        }
    }
}

extension UserCardsVC: CardSelectionDelegate {
    func didSelectCard(index: Int) {
        let vc = Router.getTransferVC()
        vc.cardSelectedIndex = index
        vc.userCards = userCards
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
