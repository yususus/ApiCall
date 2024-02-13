//
//  ViewModel.swift
//  ApiFetch
//
//  Created by yusuf on 13.02.2024.
//

import Foundation

struct Course : Hashable, Codable {
    let name : String
    let image: String
}
class ViewModel: ObservableObject {
    @Published var courses : [Course] = []
    func fetch() {
        guard let url = URL(string: "https://iosacademy.io/api/v1/courses/") else {return}
        
        let task = URLSession.shared.dataTask(with: url){[weak self] data, _ , error in
            guard let data = data ,error == nil else {
                return
            }
            //Convert to json
            
            do {
                let courses = try JSONDecoder().decode([Course].self, from: data)
                DispatchQueue.main.async {
                    self?.courses = courses
                }
            }catch{
                print(error)
            }
        }
        task.resume()
    }
}
