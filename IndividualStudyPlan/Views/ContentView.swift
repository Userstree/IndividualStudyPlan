//
//  ContentView.swift
//  IndividualStudyPlan
//
//  Created by Dossymkhan Zhulamanov on 06.04.2022.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var modelData: ModelData
    @State private var currentTab: Int = 0
 
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .center, spacing: 0)
            {
                HStack(alignment: .center)
                {
                    Spacer()
                    Button(
                        action: {
                            self.presentationMode.wrappedValue.dismiss()
                        },
                        label: {
                            Image(systemName: "chevron.backward")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .frame(width: 20, height: 20)
                        }
                    )
                    Spacer()
                    Text("Индивидуальный учебный план")
                        .foregroundColor(.white)
                        .font(.headline)
                        .lineLimit(1)
                    
                    Spacer()
                    Button (
                        action: {
                            savePdf(urlString: modelData.planData.DocumentURL, fileName: "Downloaded")
                        },
                        label: {
                            Image(systemName: "arrow.down.doc")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .frame(width: 20, height: 20)
                        }
                    )
                    Spacer()
                }
                .padding(.bottom, 20)
                .padding(.top, 45)
                .frame(maxWidth: .infinity)
                .background(LinearGradient(colors: [Color.red.opacity(0.9), Color.red.opacity(0.6)], startPoint: .leading, endPoint: .trailing))
                .ignoresSafeArea()
                
                VStack {
                    Text("Индивидуальный учебный план на \(modelData.planData.AcademicYear)")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .frame(maxWidth: 290)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                        .textCase(.uppercase)
                    
                    Text("Жарылгап Карашаш Алмаскызы")
                        .padding(EdgeInsets(top: 6, leading: 6, bottom: 6, trailing: 6))
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                        .padding(.bottom, 20)
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 0)
                
                HStack(spacing: 0)
                {
                    VStack(spacing: 0)
                    {
                        Text("Семестр \(modelData.planData.Semesters[0].Number)")
                            .font(.headline)
                            .foregroundColor(self.currentTab == 0 ? Color.black : Color.gray)
                            .padding(.bottom, 8)
                        
                        Capsule()
                            .fill(self.currentTab == 0 ? Color.yellow : Color.clear)
                            .frame(width: proxy.size.width/2, height: 3)
                        Divider()
                    }
                    .onTapGesture {
                        withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.6)){
                            currentTab = 0
                        }
                    }
                    
                    VStack(spacing: 0)
                    {
                        Text("Семестр \(modelData.planData.Semesters[1].Number)")
                            .font(.headline)
                            .foregroundColor(self.currentTab == 1 ? Color.black : Color.gray)
                            .padding(.bottom, 8)
                        
                        Capsule()
                            .fill(self.currentTab == 1 ? Color.yellow : Color.clear)
                            .frame(width: proxy.size.width/2, height: 3)
                        Divider()
                    }
                    .onTapGesture {
                        withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.6)){
                            currentTab = 1
                        }
                    }
                }
                .padding(.top)
                
                Table(tab: $currentTab, disciplines: modelData.planData.Semesters[currentTab].Disciplines)
                
            }
            .navigationBarHidden(true)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}


