//
//  CustomHeaderView.swift
//  Lesson8
//
//  Created by Светлана on 22.03.2022.
//

import Foundation
import UIKit

final class CustomHeaderView: UITableViewHeaderFooterView {
    
    private lazy var titile: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureHeader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHeader(title: String) {
        self.titile.text = title.uppercased()
    }
}

extension CustomHeaderView {
    private func configureHeader() {
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(titile)
        
        NSLayoutConstraint.activate([
            titile.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titile.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titile.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titile.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
}
