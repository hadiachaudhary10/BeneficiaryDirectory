//
//  ViewController.swift
//  BeneficiariesTestProject
//
//  Created by Dev on 15/03/2024.
//

let UITableViewRowHeight = 120

import UIKit

class BeneficiaryListViewController: UIViewController {
    private var tableView: UITableView!
    private var placeholderLabel: UILabel!
    private var viewModel = BeneficiaryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Beneficiaries"
        
        setupTableView() 
        setUpNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setUpNavigationBar() { //styling navigation bar for better UI experience
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .themeColor
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        tableView.register(BeneficiaryTableViewCell.self, forCellReuseIdentifier: "cell") // setting cell type for tableview
        tableView.separatorStyle = .none
        
        placeholderLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 100)) // in case we do not receive data from backend
        placeholderLabel.text = "No data available"
        placeholderLabel.textAlignment = .center
        placeholderLabel.isHidden = viewModel.result == .NoData ? false : true
        tableView.backgroundView = placeholderLabel
    }
}

// MARK: TableView Datasource Methods

extension BeneficiaryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.beneficiaries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BeneficiaryTableViewCell
        let beneficiary = viewModel.beneficiaries[indexPath.row]
        cell.configure(with: beneficiary) //setting beneficiary cell
        cell.selectionStyle = .none //setting selection to none as we have our own styling options
        return cell
    }
}

// MARK: TableView Delegate Methods

extension BeneficiaryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(UITableViewRowHeight) //cell row height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let beneficiary = viewModel.beneficiaries[indexPath.row]
        let detailVC = BeneficiaryDetailViewController(beneficiary: beneficiary)
        detailVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(detailVC, animated: true) // navigating to beneficiary's details view
        tableView.deselectRow(at: indexPath, animated: true) //deselecting row for better UI experience
    }
}
