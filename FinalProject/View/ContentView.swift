
//  ContentView.swift
//  FinalProject
//
//  Created by 조일현 on 2021/12/12.
//

import SwiftUI

struct ContentView: View {
<<<<<<< HEAD
    @State var photoUrl = ""
=======

>>>>>>> merged
    @StateObject var viewModel = ViewModel()
    @State var photoIsShowing = false
    
    
    
    
    let columns = [
        GridItem(spacing: 10),
        GridItem(),
    ]
    
    var body: some View {
        VStack {
            SearchBarView(viewModel: viewModel)
            ScrollView {
               GridView(viewModel: viewModel)
                .padding([.leading, .trailing], 15.0)
            }.onAppear(perform: { viewModel.searchPhotos() })
        }
        .background(Color("GridBackgroundColor"))
    }
}

struct SearchBarView : View {
    
    @ObservedObject var viewModel : ViewModel
    
    var body: some View {
        HStack {
            TextField("Search here", text: $viewModel.keyword, onCommit: {
                viewModel.searchPhotos()
            })
<<<<<<< HEAD
            
            
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
                
            
=======
                .font(Font.custom("NotoSansKR-Bold", size: 15.0))
            Button(action: {
                viewModel.searchPhotos()
            }) {
                Image("MagnifyingGlassImage")
                    .foregroundColor(.black)
            }
        }
        .padding([.leading, .trailing], 15.0)
        .padding(.top, 12.0)
        .padding(.bottom, 13.0)
        .background(.white)
        .cornerRadius(10.0)
        .shadow(color: Color("ShadowColor"), radius: 4.0, x: 3.0, y: 3.0)
        .padding(15.0)
    }
}


struct GridView : View {
    @State var photoUrl = ""
    @State var photoIsShowing = false
    @ObservedObject var viewModel : ViewModel
    
    let columns = [
        GridItem(spacing: 10),
        GridItem()
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10.0) {
            ForEach(Array(viewModel.photos.enumerated()), id: \.0) { (index, photo) in
                Button(action: {
                    photoIsShowing = true
//                   photoId = photo.id
                    photoUrl = photo.regularUrl
                }){
                AsyncImage(url: URL(string: photo.thumbnailUrl)) { image in
                    image
                        .resizable(resizingMode : .tile)
                        .cornerRadius(10.0)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: Constants.PhotoGrid.photoWidth,
                       height: Constants.PhotoGrid.photoHeight)
                .overlay(
                    PhotoInfoView(viewModel: viewModel,
                                  locationFontSize: Constants.PhotoGrid.locationFontSize,
                                  userIdFontSize: Constants.PhotoGrid.userIdFontSize,
                                  location: photo.user.location,
                                  userName: photo.user.name,
                                  profileURL: URL(string : photo.user.profileImageUrl)
                                 )
                        .padding([.leading, .bottom], 10.0),
                    alignment: .bottomLeading
                )
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
                
            }.onAppear(perform: { viewModel.searchPhotos() })
>>>>>>> merged
        }
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

<<<<<<< HEAD

=======
>>>>>>> merged
extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}
