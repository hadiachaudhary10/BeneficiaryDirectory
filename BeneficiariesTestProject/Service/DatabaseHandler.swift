//
//  DatabaseHandler.swift
//  BeneficiariesTestProject
//
//  Created by Dev on 16/03/2024.
//

import Foundation

// MARK: Fetching Data Error Cases

enum ResultType: Error {
    case Success
    case NoData
    case Fetching
}

// MARK: Beneficiary Service Delegate

protocol BeneficiaryServiceDelegate { //this delegate can be later used to implement Network Manager
    func getBeneficiaries() async throws -> [Beneficiary]
}

struct DatabaseHandler: BeneficiaryServiceDelegate {
    func getBeneficiaries() async throws -> [Beneficiary] {
        //fetching beneficiary from the source file
        guard let path = Bundle.main.path(forResource: "Beneficiaries", ofType: "json") else {
            throw ResultType.NoData
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            return try JSONDecoder().decode([Beneficiary].self, from: data) //returning data as a Beneficiary Model
        } catch let error as NSError {
            throw error
        }
    }
}
