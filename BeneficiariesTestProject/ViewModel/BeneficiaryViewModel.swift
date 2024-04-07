//
//  BeneficiaryViewModel.swift
//  BeneficiariesTestProject
//
//  Created by Dev on 16/03/2024.
//

import Foundation

class BeneficiaryViewModel: ObservableObject {
    @Published var beneficiaries: [Beneficiary] = [] //beneficiaries list
    @Published var result: ResultType = .Fetching //fetching data state
    
    let databaseHandler: BeneficiaryServiceDelegate
    
    init(databaseHandler: BeneficiaryServiceDelegate = DatabaseHandler()) {
        self.databaseHandler = databaseHandler
        fetchBeneficiaries()
    }
    
    private func fetchBeneficiaries() {
        Task {
            do {
                beneficiaries = try await databaseHandler.getBeneficiaries() //getting beneficiaries list from fatabase
                result = .Success //updating fetching data state
            } catch {
                result = .NoData 
            }
        }
    }
}
