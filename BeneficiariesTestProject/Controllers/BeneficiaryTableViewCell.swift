//
//  BeneficiaryItemCell.swift
//  BeneficiariesTestProject
//
//  Created by Dev on 16/03/2024.
//

import UIKit

class BeneficiaryTableViewCell: UITableViewCell {
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .themeColor
        return label
    }()
    
    lazy var  typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .darkGray
        return label
    }()
    
    lazy var  designationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .darkGray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        accessoryType = .disclosureIndicator // show arrow to indicate it is clickable
        contentView.backgroundColor = UIColor.rowThemeColor
        contentView.frame = bounds.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)) //adding padding from all sides
        contentView.layer.cornerRadius = 5
        
        //setting a shadow around a cell
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
    }
    
    func setUpUI() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(typeLabel)
        contentView.addSubview(designationLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false //allow to activate constraints
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        designationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            typeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            typeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            designationLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 4),
            designationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            designationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            designationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with beneficiary: Beneficiary) { //configure cell values
        nameLabel.text = "\(beneficiary.firstName) \(beneficiary.middleName ?? "") \(beneficiary.lastName)"
        typeLabel.text = "Type: \(beneficiary.beneType)"
        designationLabel.text = "Designation: \(beneficiary.designationCode == "P" ? "Primary" : "Contingent")"
    }
}

