//
//  ViewModel.swift
//  FinalProject
//
//  Created by 조일현 on 2021/12/12.
//

import Foundation
import Combine

class ViewModel: ObservableObject {

    private var cancellables = Set<AnyCancellable>()

    private var isLoading = false
    private var currentPage = 0
    private var keyword = ""

    @Published var photos: [Photo] = []

    private func fetchPhotos() {
        UnsplashClient.shared.getPhotos(page: currentPage)
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { _ in self.isLoading = false },
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
                receiveCompletion: { _ in self.isLoading = false },
                receiveValue: { [weak self] photos in
                    guard let self = self else { return }
                    self.isLoading = false
                    self.photos = self.photos + photos
                    self.currentPage += 1
                }
            )
            .store(in: &cancellables)
    }

    func searchPhotos(query: String) {
        if isLoading { return }
        isLoading = true
        if query != keyword {
            currentPage = 0
            photos = []
        }
        keyword = query
        if (keyword == "") {
            fetchPhotos()
        } else {
            fetchSearchPhotos(query: query)
        }
    }

    func loadMore(index: Int) {
        if (index > photos.count - 6) {
            searchPhotos(query: keyword)
        }
    }
}
