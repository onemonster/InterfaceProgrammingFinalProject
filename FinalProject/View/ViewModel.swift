//
//  ViewModel.swift
//  FinalProject
//
//  Created by 조일현 on 2021/12/12.
//

import Foundation
import Combine
import UIKit

class ViewModel: ObservableObject {

    private var cancellables = Set<AnyCancellable>()

    private var isLoading = false
    private var currentPage = 0
    private var lastKeyword = ""
    @Published var keyword = ""

    @Published var photos: [Photo] = []
    @Published var selectedPhotos: [Photo] = []
    @Published var selectedPhotoID: String = ""
    
    
    
    private func showPhote() {
        
    }

    private func fetchPhotos() {
        UnsplashClient.shared.getPhotos(page: currentPage)
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { error in
                    self.isLoading = false
                    print(error)
                },
                receiveValue: { [weak self] photos in
                    guard let self = self else { return }
                    self.isLoading = false
                    self.photos = self.photos + photos
                    self.currentPage += 1
                }
            )
            .store(in: &cancellables)
    }

    private func fetchSearchPhotos(query: String) {
        UnsplashClient.shared.searchPhotos(query: query, page: currentPage)
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { error in
                    self.isLoading = false
                    print(error)
                },
                receiveValue: { [weak self] photos in
                    guard let self = self else { return }
                    self.isLoading = false
                    self.photos = self.photos + photos
                    self.currentPage += 1
                }
            )
            .store(in: &cancellables)
    }

    func searchPhotos() {
        if isLoading { return }
        isLoading = true
        if lastKeyword != keyword {
            currentPage = 0
            photos = []
        }
        lastKeyword = keyword
        if (keyword == "") {
            fetchPhotos()
        } else {
            fetchSearchPhotos(query: keyword)
        }
    }

    func loadMore(index: Int) {
        if (index > photos.count - 6) {
            searchPhotos()
        }
    }
    


    
    
    
    
}
