//
//  Table.swift
//  IndividualStudyPlan
//
//  Created by Dossymkhan Zhulamanov on 08.04.2022.
//

import SwiftUI

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
                                        heights![0] = proxy.size.height + 23
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
                            ForEach(0..<disciplines.count) { column in
                                VStack(spacing: 0)
                                {
                                    Text(column == 0 ? NSLocalizedString("Lecture", comment: "") :
                                            column == 1 ? NSLocalizedString("Seminar", comment: "") : NSLocalizedString("Lab.", comment: ""))
                                        .frame(width: 80, height: heights![0])
                                        .border(Color.gray,width: 0.2)
                                        .foregroundColor(Color.gray)

                                    ForEach(0..<disciplines[column].Lesson.count) { row in
                                        HStack(spacing: 0)
                                        {
                                            Text(disciplines[row].Lesson[column].RealHours)
                                                .foregroundColor(Color.green)
                                            Text(" / ")
                                                .foregroundColor(.gray)
                                            Text(disciplines[row].Lesson[column].Hours)
                                                .foregroundColor(disciplines[row].Lesson[column].RealHours == disciplines[row].Lesson[column].Hours ? .green : .red)
                                        }
                                        .frame(width: 80, height: heights![row + 1])
                                        .border(Color.gray,width: 0.2)
                                    }
                                    Spacer()
                                }
                            }
                        }
                        .padding(.top, 5)
                        Spacer()
                    }
                }
            }
        }
    }
}
