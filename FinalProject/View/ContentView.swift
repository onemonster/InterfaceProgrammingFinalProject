
//  ContentView.swift
//  FinalProject
//
//  Created by 조일현 on 2021/12/12.
//

import SwiftUI

struct ContentView: View {
    @State var photoUrl = ""
    @StateObject var viewModel = ViewModel()
    @State var photoIsShowing = false
    
    
    
    let columns = [
        GridItem(spacing: 10),
        GridItem(),
    ]
    
    var body: some View {
        VStack {
            TextField("Search here", text: $viewModel.keyword, onCommit: {
                viewModel.searchPhotos()
            })
            
            
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 5.0) {
                        
                            ForEach(Array(viewModel.photos.enumerated()), id: \.0) { (index, photo) in
                                Button(action: {
                                    photoIsShowing = true
//                                    photoId = photo.id
                                    photoUrl = photo.regularUrl
                                }){
                                        AsyncImage(url: URL(string: photo.thumbnailUrl))
                                        .onAppear(perform: {
                                            viewModel.loadMore(index: index)
                                        })
                                    
                                }
                                .sheet(isPresented: $photoIsShowing) {} content: {
                                    AsyncImage(url: URL(string: photoUrl)){ phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                        case .success(let image):
                                            image.resizable()
                                                 .aspectRatio(contentMode: .fit)
                                        case .failure:
                                            Image(systemName: "photo")
                                        @unknown default:

                                            EmptyView()
                                        }
                                    }


                                }
                                
                                
                            }
                            
                        
                        }
                        
                    
                }.onAppear(perform: { viewModel.searchPhotos() })
                
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}
