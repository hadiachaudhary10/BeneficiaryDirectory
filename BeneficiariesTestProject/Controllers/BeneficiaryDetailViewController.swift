//
//  BeneficiaryDetailViewController.swift
//  BeneficiariesTestProject
//
//  Created by Dev on 16/03/2024.
//

import UIKit

class BeneficiaryDetailViewController: UIViewController {
    private let beneficiary: Beneficiary
    
    init(beneficiary: Beneficiary) {
        self.beneficiary = beneficiary
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(beneficiary.firstName) \(beneficiary.lastName)"
        view.backgroundColor = .white
   
        let stackView = createStackView()
        view.addSubview(stackView)
        
        // setting constraints for the stack view
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    private func createStackView() -> UIStackView { //creating stack view for the entire view
        let typeLabel = createTypeLabel(with: "Type", and: "\(beneficiary.beneType)", color: .themeColor ?? .blue)
        let ssnLabel = createTypeLabel(with: "SSN", and: "\(beneficiary.socialSecurityNumber)", color: .themeColor ?? .blue)
        let dobLabel = createTypeLabel(with: "Date of Birth", and: formatDateString(beneficiary.dateOfBirth), color: .themeColor ?? .blue)
        let phoneNumberLabel = createTypeLabel(with: "Phone Number", and: "\(beneficiary.phoneNumber)", color: .themeColor ?? .blue)
        let addressLabel = createTypeLabel(with: "Address", and: "\(beneficiary.beneficiaryAddress.firstLineMailing), \(beneficiary.beneficiaryAddress.city), \(beneficiary.beneficiaryAddress.stateCode), \(beneficiary.beneficiaryAddress.zipCode)", color: .themeColor ?? .blue)
        
        
        let stackView = UIStackView(arrangedSubviews: [createHeaderStack(), typeLabel, ssnLabel, dobLabel, phoneNumberLabel, addressLabel])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .leading
        
        return stackView
    }
    
    private func createHeaderStack() -> UIStackView { //creating header stack with name and designation
        let iconImageView = UIImageView(image: UIImage(systemName: "person.fill"))
        iconImageView.tintColor = .rowThemeColor
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        let nameLabel = createLabel(with: "\(beneficiary.firstName) \(beneficiary.middleName ?? "") \(beneficiary.lastName)", textStyle: .title3, bold: true, color: .themeColor ?? .blue)
        let designationLabel = createLabel(with: "\(beneficiary.designationCode == "P" ? "Primary" : "Contingent")", textStyle: .body, bold: false, color: .gray)
        
        let headerRightStack = UIStackView(arrangedSubviews: [nameLabel, designationLabel])
        headerRightStack.axis = .vertical
        headerRightStack.spacing = 10
        headerRightStack.alignment = .leading
        
        let headerStackView = UIStackView(arrangedSubviews: [iconImageView, headerRightStack])
        headerStackView.axis = .horizontal
        headerStackView.spacing = 15
        headerStackView.alignment = .leading
        
        return headerStackView
    }
    
    private func createLabel(with text: String, textStyle: UIFont.TextStyle, bold: Bool, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.font = bold ? UIFont.boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: textStyle).pointSize) : UIFont.preferredFont(forTextStyle: textStyle)
        label.textColor = color
        return label
    }
    
    private func createTypeLabel(with title: String, and body: String, color: UIColor) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.alignment = .leading
        
        let titleLabel = createLabel(with: title, textStyle: .footnote, bold: false, color: .gray)
        let bodyLabel = createLabel(with: body, textStyle: .body, bold: false, color: color)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(bodyLabel)
        
        return stackView
    }
    
    private func formatDateString(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMddyyyy"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "MM/dd/yyyy"
            return dateFormatter.string(from: date)
        } else {
            return "Invalid date"
        }
    }

}
