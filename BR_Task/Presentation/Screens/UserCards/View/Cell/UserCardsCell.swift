//
//  UserCardsCell.swift
//  BR_Task
//
//  Created by Nazim Asadov on 31.03.24.
//

import UIKit

protocol CardSelectionDelegate: AnyObject {
    func didSelectCard(index: Int)
}

class UserCardsCell: UICollectionViewCell {
    
    private var index = 0
    weak var delegate: CardSelectionDelegate?
    
    private lazy var applePayImgView : UIImageView = {
        let imgView = UIImageView()
        
        imgView.contentMode = .scaleAspectFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = .applePay.withTintColor(.white)

        contentView.addSubview(imgView)
        return imgView
    }()
    
    private lazy var cardNameLbl: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        label.text = "MyCard"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        
        contentView.addSubview(label)
        return label
    }()
    
    private lazy var cardAmountLbl: UILabel = {
        let label = UILabel()

        label.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        
        contentView.addSubview(label)
        return label
    }()
    
    private lazy var cardInfoStack: UIStackView = {
       let stack = UIStackView()
            
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .equalCentering
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
            
        contentView.addSubview(stack)
        return stack
    }()
    
    private lazy var cardNumberLbl: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
//        label.text = "** 3284"
        label.textColor = .white

        return label
    }()    
    
    private lazy var expireDateLbl: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white

        return label
    }()
    
    private lazy var cardTypeImgView : UIImageView = {
        let imgView = UIImageView()
        
        imgView.contentMode = .scaleAspectFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = .mastercard
        
        contentView.addSubview(imgView)
        return imgView
    }()  
    
    private lazy var transferView : UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        
//        imgView.image = .
        
        contentView.addSubview(view)
        return view
    }()
    
    private lazy var transferBtn : UIButton = {
        let btn = UIButton()
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(.transfer.withTintColor(.white), for: .normal)
        btn.tintColor = .systemBlue
        btn.addTarget(self, action: #selector(transferPressed), for: .touchUpInside)
        
        transferView.addSubview(btn)
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    @objc func transferPressed() {
        delegate?.didSelectCard(index: self.index)        
    }
    
    private func setupUI() {
        contentView.backgroundColor = .systemBlue.withAlphaComponent(0.8)
        clipsToBounds = true
        layer.cornerRadius = 16
        
        cardInfoStack.addArrangedSubview(cardNumberLbl)
        cardInfoStack.addArrangedSubview(expireDateLbl)
    }
    
    private func setupConstraints() {
                
        NSLayoutConstraint.activate([
            
            cardNameLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            cardNameLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cardNameLbl.trailingAnchor.constraint(equalTo: applePayImgView.leadingAnchor, constant: -16),
            
            applePayImgView.heightAnchor.constraint(equalToConstant: 30),
            applePayImgView.widthAnchor.constraint(equalToConstant: 50),
            applePayImgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            applePayImgView.centerYAnchor.constraint(equalTo: cardNameLbl.centerYAnchor),

            cardAmountLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            cardAmountLbl.topAnchor.constraint(equalTo: cardNameLbl.bottomAnchor, constant: 30),
            cardAmountLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            
            cardTypeImgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cardTypeImgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            cardTypeImgView.heightAnchor.constraint(equalToConstant: 24),
            cardTypeImgView.widthAnchor.constraint(equalToConstant: 50),
            
            cardInfoStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cardInfoStack.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20),
            cardInfoStack.bottomAnchor.constraint(equalTo: cardTypeImgView.topAnchor, constant: -20),
            
            transferView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            transferView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            transferBtn.heightAnchor.constraint(equalToConstant: 24),
            transferBtn.widthAnchor.constraint(equalToConstant: 24),
            transferBtn.trailingAnchor.constraint(equalTo: transferBtn.superview!.trailingAnchor, constant: -8),
            transferBtn.leadingAnchor.constraint(equalTo: transferBtn.superview!.leadingAnchor, constant: 8),
            transferBtn.bottomAnchor.constraint(equalTo: transferBtn.superview!.bottomAnchor, constant: -8),
            transferBtn.topAnchor.constraint(equalTo: transferBtn.superview!.topAnchor, constant: 8),
            
        ])
    }
    
    func setupCell(model: CardInfoEntity, index: Int) {
        self.index = index
        cardAmountLbl.text = (model.amount ?? "") + "₼‎"
        if let cardNumber = model.cardNumber {
            let lastFourNumber = String(cardNumber.dropFirst(12))
            cardNumberLbl.text = "** " + "\(lastFourNumber)"
        }
        expireDateLbl.text = model.expireDate
    }
}
