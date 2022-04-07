//
//  IndividualPlan.swift
//  IndividualStudyPlan
//
//  Created by Dossymkhan Zhulamanov on 06.04.2022.
//

import SwiftUI

struct IndividualPlan: View {
    var body: some View
    {
        NavigationView
        {
            NavigationLink("Tap here",
                           destination: ContentView()
                                .environmentObject(ModelData())
            )
            .font(.title)
            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)

        }
    }
}

struct IndividualPlan_Previews: PreviewProvider {
    static var previews: some View {
        IndividualPlan()
    }
}
