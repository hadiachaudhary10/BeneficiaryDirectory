//
//  BeneficiaryModel.swift
//  BeneficiariesTestProject
//
//  Created by Dev on 15/03/2024.
//

import Foundation

struct Beneficiary: Codable { 
    let lastName: String
    let firstName: String
    let designationCode: String
    let beneType: String
    let socialSecurityNumber: String
    let dateOfBirth: String
    let middleName: String?
    let phoneNumber: String
    let beneficiaryAddress: Address
}

struct Address: Codable {
    let firstLineMailing: String
    let scndLineMailing: String?
    let city: String
    let zipCode: String
    let stateCode: String
    let country: String
}
