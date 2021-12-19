//
//  PhotoInfoView.swift
//  FinalProject
//
//  Created by Johyeon Yoon on 2021/12/14.
//

import SwiftUI

struct PhotoInfoView : View {
    
    @ObservedObject var viewModel : ViewModel

    let locationFontSize : CGFloat
    let userIdFontSize : CGFloat
    let location : String?
    let userName : String
    let profileURL : URL?
    
    var body: some View {
        HStack(spacing: 10.0) {
            ProfileImageView(url: profileURL)
            ProfileTextView(location: location,
                          userName: userName,
                          locationFontSize: locationFontSize,
                          userIdFontSize: userIdFontSize)
        }
    }
}

struct ProfileImageView : View {
    let url : URL?
    
    var body: some View {
        if let url = url {
            Image("DefaultProfileImage")
                .data(url: url)
                .frame(width: Constants.PhotoGrid.profileImageCircleSize,
                       height: Constants.PhotoGrid.profileImageCircleSize)
                .clipShape(Circle())
        }
    }
}


struct ProfileTextView : View {
    
    let location : String?
    let userName : String
    let locationFontSize : CGFloat
    let userIdFontSize : CGFloat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1.0) {
            Text(location ?? "")
                .font(Font.custom("NotoSansKR-Medium", size: locationFontSize))
            Text(userName)
                .font(Font.custom("NotoSansKR-Bold", size: userIdFontSize))
        }
        .foregroundColor(.white)
        .shadow(color: .black, radius: 10.0)
    }
}



extension Image {
    func data(url: URL) -> Self {
        if let data = try? Data(contentsOf: url){
            return Image(uiImage: UIImage(data: data)!)
                .resizable()
        }
        return self
            .resizable()
    }
}
