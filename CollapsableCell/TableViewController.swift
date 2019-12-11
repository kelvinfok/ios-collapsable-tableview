//
//  ViewController.swift
//  CollapsableCell
//
//  Created by Kelvin Fok on 10/12/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import UIKit

struct Model {
    let title: String
    let color: UIColor
    var isCollapsed: Bool
}

class ViewModel {
    
    var item = [Model]()
    
    init() {
        item = [Model(title: "Title 1", color: .systemGroupedBackground, isCollapsed: false),
                Model(title: "Title 2", color: .systemGroupedBackground, isCollapsed: true),
                Model(title: "Title 3", color: .systemGroupedBackground, isCollapsed: true)
        ]
    }
}

class TableViewController: UITableViewController {
    
    private var viewModel = ViewModel()
    private var lastSelected = IndexPath(item: 0, section: 0)
    
    private let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(CollapsableCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CollapsableCell
        let model = self.viewModel.item[indexPath.item]
        cell.setupViews(model: model)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if viewModel.item[indexPath.item].isCollapsed {
            return 56
        } else {
           return 180
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.item.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath != lastSelected else { return }
        viewModel.item[indexPath.item].isCollapsed.toggle()
        viewModel.item[lastSelected.item].isCollapsed.toggle()
        tableView.reloadRows(at: [indexPath, lastSelected], with: .automatic)
        lastSelected = indexPath
    }


}

class CollapsableCell: UITableViewCell {
        
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var paymentLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var codeTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    
    lazy var descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(model: Model) {
        
        backgroundColor = model.color
        titleLabel.text = model.title
        
        addSubview(titleLabel)
        addSubview(paymentLabel)
        addSubview(codeTextField)
        addSubview(descriptionTextField)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.heightAnchor.constraint(equalToConstant: 24),
            
            paymentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            paymentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            paymentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            paymentLabel.heightAnchor.constraint(equalToConstant: 24),
            
            codeTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            codeTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            codeTextField.topAnchor.constraint(equalTo: paymentLabel.bottomAnchor, constant: 16),
            codeTextField.heightAnchor.constraint(equalToConstant: 24),
            
            descriptionTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            descriptionTextField.topAnchor.constraint(equalTo: codeTextField.bottomAnchor, constant: 16),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 24)

            
        ])
        clipsToBounds = true

        
    }
    
    
}
