//
//  ContentView.swift
//  ApiFetch
//
//  Created by yusuf on 13.02.2024.
//

import SwiftUI

struct URLImage: View {
    let urlString: String
    @State var data : Data?
    var body: some View {
        if let data = data, let uiimage = UIImage(data: data){
            Image(uiImage: uiimage).resizable().aspectRatio(contentMode: .fill).frame(width: 130, height: 70)
                .background(Color.gray)
            
        }else{
            Image(systemName: "photo").resizable().aspectRatio(contentMode: .fit).frame(width: 130, height: 70)
                .background(Color.gray)
                .onAppear{
                    fethcData()
                }
        }
    }
    
    private func fethcData() {
        guard let url = URL(string: urlString) else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            self.data = data
        }
        task.resume()
    }
}


struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    var body: some View {
        NavigationView{
            List{
                ForEach(viewModel.courses, id: \.self){
                    course in
                    HStack{
                        URLImage(urlString: course.image)
                        Text(course.name).bold()
                    }.padding(3)
                }
            }.navigationTitle("Courses")
                .onAppear{
                    viewModel.fetch()
                }
        }
    }
}

#Preview {
    ContentView()
}
