//
//  ModelData.swift
//  IndividualStudyPlan
//
//  Created by Dossymkhan Zhulamanov on 06.04.2022.
//

import Foundation

class ModelData: ObservableObject {
    @Published var planData: Plan = load("Method2.json")
}


func load<T: Decodable>(_ filename: String) -> T{
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
        fatalError("Couldn't find \(filename) in main Bundle")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from the Bundle: \n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self): \n\(error)")
    }
}
