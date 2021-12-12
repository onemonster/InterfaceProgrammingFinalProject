
//  ContentView.swift
//  FinalProject
//
//  Created by 조일현 on 2021/12/12.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
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
                        AsyncImage(url: URL(string: photo.thumbnailUrl))
                            .onAppear(perform: {
                                viewModel.loadMore(index: index)
                            })
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
