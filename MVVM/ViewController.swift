//
//  ViewController.swift
//  MVVM
//
//  Created by Jason Yang on 1/31/24.
//

import UIKit

// Model
struct Item {
    var name: String
}

// ViewModel
class ItemViewModel {
    var items: [Item] = []

    func fetchItems() {
        // 모델에서 데이터를 가져와 ViewModel에 할당
        // 이 예제에서는 간단히 하드코딩된 데이터를 사용
        items = [
            Item(name: "Item 1"),
            Item(name: "Item 2"),
            Item(name: "Item 3")
        ]
    }
}

// View
class ItemListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var viewModel = ItemViewModel() // ItemViewModel() 프로퍼티화

    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "ItemCell")
        table.dataSource = self
        table.delegate = self
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // UITableView 추가
        view.addSubview(tableView)

        // Auto Layout 설정
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        // 데이터를 가져오는 함수 호출
        viewModel.fetchItems()  // ViewModel인 ItemViewModel의 매소드인 fetchItems()을 초기화한 viewModel 프로퍼티에 주입
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        let item = viewModel.items[indexPath.row]
        cell.textLabel?.text = item.name
        return cell
    }
}

