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
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
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
        let section = Int.random(in: 0...models.count - 1)
        let randomHeroIndex = Int.random(in: 0...models[section].heroes.count - 1)
        let randomHero = models[section].heroes[randomHeroIndex]
        data[0].heroes.append(randomHero)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let hero = self.data[sourceIndexPath.section].heroes.remove(at: sourceIndexPath.row)
        self.data[destinationIndexPath.section].heroes.insert(hero, at: destinationIndexPath.row)
        tableView.reloadData()
    }
}

//MARK: - UITableViewDragDelegate, UITableViewDropDelegate
extension ViewController: UITableViewDragDelegate, UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item = UIDragItem(itemProvider: NSItemProvider())
        item.localObject = indexPath
        return [item]
    }

    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        guard let item = coordinator.session.items.first,
              let sourceIndexPath = item.localObject as? IndexPath,
              let destinationIndexPath = coordinator.destinationIndexPath
        else {
            return
        }

        switch coordinator.proposal.intent {
          case .insertAtDestinationIndexPath:
            tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
            coordinator.drop(item, toRowAt: destinationIndexPath)
          default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if session.items.first != nil {
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        } else {
            return UITableViewDropProposal(operation: .forbidden)
        }
    }
}
