//
//  HeroCell.swift
//  Lesson8
//
//  Created by Светлана on 22.03.2022.
//

import Foundation
import UIKit

final class HeroCell: UITableViewCell {
    
    private lazy var imageHero: UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 30
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var name: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var realName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(name: String, realName: String?, image: String?) {
        self.name.text = name
        if let image = image {
            self.imageHero.image = UIImage(named: image)
        } else {
            self.imageHero.image = UIImage(systemName: "person")
        }
        if let realName = realName {
            self.realName.text = realName
        } else {
            self.realName.text = ""
        }
    }
}

// MARK: - Private Methods
extension HeroCell {
    private func configureCell() {
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(imageHero)
        contentView.addSubview(name)
        contentView.addSubview(realName)
        
        NSLayoutConstraint.activate([
            imageHero.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageHero.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            imageHero.widthAnchor.constraint(equalToConstant: 60),
            imageHero.heightAnchor.constraint(equalToConstant: 60),
//            imageHero.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
            
            name.topAnchor.constraint(equalTo: imageHero.topAnchor),
            name.leadingAnchor.constraint(equalTo: imageHero.trailingAnchor, constant: 8),
            name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            realName.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 1),
            realName.leadingAnchor.constraint(equalTo: imageHero.trailingAnchor, constant: 8),
            realName.trailingAnchor.constraint(equalTo: name.trailingAnchor),
//            realName.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
        ])
    }
}
