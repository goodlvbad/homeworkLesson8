//
//  ViewController.swift
//  Lesson8
//
//  Created by Светлана on 22.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let customCellId = "customCellId"
    private let customHeaderId = "customHeaderId"
    
    private var data: [MarvelModel] = models
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.estimatedRowHeight = 78
//        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(HeroCell.self, forCellReuseIdentifier: customCellId)
        tableView.register(CustomHeaderView.self, forHeaderFooterViewReuseIdentifier: customHeaderId)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarAppearance()
        setupNavigationBarItems()
        setupTableView()
    }
}

//MARK: - Private Methods
extension ViewController {
    private func setupTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .red
        appearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 28.0),
                                          .foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupNavigationBarItems() {
        title = "Marvel".uppercased()
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItem = addItem
    }
    
    @objc private func didTapAddButton() {
        print("didTapAddButton")
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].heroes.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: customCellId, for: indexPath) as! HeroCell
        let model = data[indexPath.section].heroes[indexPath.row]
        cell.setupCell(name: model.name, realName: model.realName, image: model.imageName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: customHeaderId) as! CustomHeaderView
        let model = data[section]
        header.setupHeader(title: model.parameter)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            data[indexPath.section].heroes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = data[sourceIndexPath.section].heroes[sourceIndexPath.row]
        data[sourceIndexPath.section].heroes.remove(at: sourceIndexPath.row)
        data[sourceIndexPath.section].heroes.insert(itemToMove, at: destinationIndexPath.row)
    }
    
}
