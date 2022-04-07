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
                HStack {
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
                            downloadFile(modelData.planData.DocumentURL)
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
                .padding(.top, 5)
                .padding(.bottom, 20)
                .frame(maxWidth: .infinity)
                .background(LinearGradient(colors: [Color.red.opacity(0.9), Color.red.opacity(0.6)], startPoint: .leading, endPoint: .trailing))
                
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

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }

}


struct Table: View {
    @Binding var tab: Int
    var disciplines: [Discipline]
    @State var heights: [Int : CGFloat]? = [0 : .zero]
    var body: some View {
        HStack
        {
            Spacer()
            Text(NSLocalizedString("Classroom classes (in hours)", comment: ""))
                .foregroundColor(.gray)
                .padding()
        }
        
        ZStack {
            HStack(spacing: 0)
            {
                VStack(alignment: .leading)
                {
                    Text(NSLocalizedString("Course Title", comment: ""))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.gray)
                        .lineLimit(2)
                        .padding(.leading)
                        .background(
                            GeometryReader { proxy in
                                Color.clear
                                    .onAppear {
                                        heights![0] = proxy.size.height + 25
                                    }
                            }
                        )
                    Divider()
                    
                    Text(NSLocale.current.languageCode == "en" ?
                         disciplines[0].DisciplineName.nameEn :
                            NSLocale.current.languageCode == "ru" ?
                         disciplines[0].DisciplineName.nameRu : disciplines[0].DisciplineName.nameKk
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.black)
                    .lineLimit(2)
                    .padding(.leading)
                    .background(
                        GeometryReader { proxy in
                            Color.clear
                                .onAppear {
                                    heights![1] = proxy.size.height + 20
                                }
                        }
                    )
                    Divider()
                    
                    Text(NSLocale.current.languageCode == "en" ?
                         disciplines[1].DisciplineName.nameEn :
                            NSLocale.current.languageCode == "ru" ?
                         disciplines[1].DisciplineName.nameRu : disciplines[1].DisciplineName.nameKk
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.black)
                    .lineLimit(2)
                    .padding(.leading)
                    .background(
                        GeometryReader { proxy in
                            Color.clear
                                .onAppear {
                                    heights![2] = proxy.size.height + 20
                                }
                        }
                    )
                    Divider()
                    
                    Text(NSLocale.current.languageCode == "en" ?
                         disciplines[2].DisciplineName.nameEn :
                            NSLocale.current.languageCode == "ru" ?
                         disciplines[2].DisciplineName.nameRu : disciplines[2].DisciplineName.nameKk
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.black)
                    .lineLimit(2)
                    .padding(.leading)
                    
                    .background(
                        GeometryReader { proxy in
                            Color.clear
                                .onAppear {
                                    heights![3] = proxy.size.height + 20
                                }
                        }
                    )
                    Spacer()
                }
                .padding(.top, 15)
                .frame(width: 170 )
                
                ScrollView(.horizontal, showsIndicators: false)
                {
                    VStack
                    {
                        HStack(spacing: 0)
                        {
                            VStack(spacing: 0)
                            {
                                Text(NSLocalizedString("Lecture", comment: ""))
                                    .frame(width: 80, height: heights![0])
                                    .border(Color.gray,width: 0.2)
                                    .foregroundColor(Color.gray)
                                
                                HStack(spacing: 0)
                                {
                                    Text(disciplines[0].Lesson[0].RealHours)
                                        .foregroundColor(Color.green)
                                    Text(" / ")
                                        .foregroundColor(.gray)
                                    Text(disciplines[0].Lesson[0].Hours)
                                        .foregroundColor(disciplines[0].Lesson[0].RealHours == disciplines[0].Lesson[0].Hours ? .green : .red)
                                }
                                .frame(width: 80, height: heights![1])
                                .border(Color.gray,width: 0.2)
                                
                                
                                HStack(spacing: 0)
                                {
                                    Text(disciplines[1].Lesson[0].RealHours)
                                        .foregroundColor(Color.green)
                                    Text(" / ")
                                        .foregroundColor(.gray)
                                    Text(disciplines[1].Lesson[0].Hours)
                                        .foregroundColor(disciplines[1].Lesson[0].RealHours == disciplines[1].Lesson[0].Hours ? .green : .red)
                                }
                                .frame(width: 80, height: heights![2])
                                .border(Color.gray,width: 0.2)
                                
                                HStack(spacing: 0)
                                {
                                    Text(disciplines[2].Lesson[0].RealHours)
                                        .foregroundColor(Color.green)
                                    Text(" / ")
                                        .foregroundColor(.gray)
                                    Text(disciplines[2].Lesson[0].Hours)
                                        .foregroundColor(disciplines[2].Lesson[0].RealHours == disciplines[2].Lesson[0].Hours ? .green : .red)
                                }
                                .frame(width: 80, height: heights![3])
                                .border(Color.gray,width: 0.2)
                                Spacer()
                            }
                            
                            VStack(spacing: 0)
                            {
                                Text(NSLocalizedString("Seminar", comment: ""))
                                    .frame(width: 80, height: heights![0])
                                    .border(Color.gray,width: 0.2)
                                    .foregroundColor(Color.gray)
                                
                                HStack(spacing: 0)
                                {
                                    Text(disciplines[0].Lesson[1].RealHours)
                                        .foregroundColor(Color.green)
                                    Text(" / ")
                                        .foregroundColor(.gray)
                                    Text(disciplines[0].Lesson[1].Hours)
                                        .foregroundColor(disciplines[0].Lesson[1].RealHours == disciplines[0].Lesson[1].Hours ? .green : .red)
                                }
                                .frame(width: 80, height: heights![1])
                                .border(Color.gray,width: 0.2)
                                
                                HStack(spacing: 0)
                                {
                                    Text(disciplines[1].Lesson[1].RealHours)
                                        .foregroundColor(Color.green)
                                    Text(" / ")
                                        .foregroundColor(.gray)
                                    Text(disciplines[1].Lesson[1].Hours)
                                        .foregroundColor(disciplines[1].Lesson[1].RealHours == disciplines[1].Lesson[1].Hours ? .green : .red)
                                }
                                .frame(width: 80, height: heights![2])
                                .border(Color.gray,width: 0.2)
                                
                                HStack(spacing: 0)
                                {
                                    Text(disciplines[2].Lesson[1].RealHours)
                                        .foregroundColor(Color.green)
                                    Text(" / ")
                                        .foregroundColor(.gray)
                                    Text(disciplines[2].Lesson[1].Hours)
                                        .foregroundColor(disciplines[2].Lesson[1].RealHours == disciplines[2].Lesson[1].Hours ? .green : .red)
                                }
                                .frame(width: 80, height: heights![3])
                                .border(Color.gray,width: 0.2)
                                Spacer()
                            }
                            
                            VStack(spacing: 0)
                            {
                                Text(NSLocalizedString("Lab.", comment: ""))
                                    .frame(width: 80, height: heights![0])
                                    .border(Color.gray,width: 0.2)
                                    .foregroundColor(Color.gray)
                                
                                HStack(spacing: 0)
                                {
                                    Text(disciplines[0].Lesson[2].RealHours)
                                        .foregroundColor(Color.green)
                                    Text(" / ")
                                        .foregroundColor(.gray)
                                    Text(disciplines[0].Lesson[2].Hours)
                                        .foregroundColor(disciplines[0].Lesson[2].RealHours == disciplines[0].Lesson[2].Hours ? .green : .red)
                                }
                                .frame(width: 80, height: heights![1])
                                .border(Color.gray,width: 0.2)
                                
                                HStack(spacing: 0)
                                {
                                    Text(disciplines[1].Lesson[2].RealHours)
                                        .foregroundColor(Color.green)
                                    Text(" / ")
                                        .foregroundColor(.gray)
                                    Text(disciplines[1].Lesson[2].Hours)
                                        .foregroundColor(disciplines[1].Lesson[2].RealHours == disciplines[1].Lesson[2].Hours ? .green : .red)
                                }
                                .frame(width: 80, height: heights![2])
                                .border(Color.gray,width: 0.2)
                                
//                                HStack(spacing: 0)
//                                {
//                                    Text(disciplines[2].Lesson[1].RealHours)
//                                        .foregroundColor(Color.green)
//                                    Text(" / ")
//                                        .foregroundColor(.gray)
//                                    Text(disciplines[2].Lesson[1].Hours)
//                                        .foregroundColor(disciplines[1].Lesson[2].RealHours == disciplines[1].Lesson[2].Hours ? .green : .red)
//                                }
//                                    .frame(width: 80, height: heights![3])
//                                    .border(Color.gray,width: 0.2)
                                Spacer()
                            }
                            
//                            ForEach(0..<2) { num in
//                                VStack(spacing: 0)
//                                {
//                                    Text(NSLocalizedString("Lab.", comment: ""))
//                                        .frame(width: 80, height: heights![0])
//                                        .border(Color.gray,width: 0.2)
//                                        .foregroundColor(Color.gray)
//
//                                    ForEach(disciplines, id: \.id) { discipline in
//                                        HStack(spacing: 0)
//                                        {
//                                            Text(discipline.Lesson[num].RealHours)
//                                                .foregroundColor(Color.green)
//                                            Text(" / ")
//                                                .foregroundColor(.gray)
//                                            Text(discipline.Lesson[num].Hours)
//                                                .foregroundColor(discipline.Lesson[num].RealHours == discipline.Lesson[num].Hours ? .green : .red)
//                                        }
//                                        .frame(width: 80, height: heights![disciplines.firstIndex(of: discipline)!])
//                                        .border(Color.gray,width: 0.2)
//                                    }
//                                    Spacer()
//                                }
//                            }
                        }
                        .padding(.top, 3)
                        Spacer()
                    }
                }
            }
        }
    }
}