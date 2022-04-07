//
//  IndividualStudyPlanApp.swift
//  IndividualStudyPlan
//
//  Created by Dossymkhan Zhulamanov on 06.04.2022.
//

import SwiftUI

@main
struct IndividualStudyPlanApp: App {
    @StateObject var modelData = ModelData()
    var body: some Scene {
        WindowGroup {
            IndividualPlan()
                .environmentObject(modelData)
        }
    }
}
