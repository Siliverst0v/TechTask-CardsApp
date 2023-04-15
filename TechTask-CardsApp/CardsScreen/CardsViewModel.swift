//
//  CardsViewModel.swift
//  TechTask-CardsApp
//
//  Created by Анатолий Силиверстов on 15.04.2023.
//

import Foundation

protocol CardsViewModelType {
    var cards: [Card] {get set}
    var canLoadMore: Bool {get set}
    var isLoading: Bool {get set}
    var onGetCardsSuccess: (() -> Void)? {get set}
    var onAuthError: (() -> Void)? {get set}
    var onBadRequestError: (() -> Void)? {get set}
    var onInternalServerError: (() -> Void)? {get set}
    func getCards(offset: Int?, completion: @escaping () -> Void)
    func getNumberOfSections() -> Int
    func getCellInfo(for indexPath: IndexPath) -> Card
    func getCompanyId(for indexPath: IndexPath) -> String
}

final class CardsViewModel: CardsViewModelType {
    private let networkManager = NetworkManager()
    
    var cards: [Card] = []
    var canLoadMore = true
    var isLoading = false
    
    var onGetCardsSuccess: (() -> Void)?
    var onAuthError: (() -> Void)?
    var onBadRequestError: (() -> Void)?
    var onInternalServerError: (() -> Void)?
    
    func getCards(offset: Int? = nil, completion: @escaping () -> Void) {
        guard let url = URL(string: StringConstants.url) else {return}
        self.isLoading = true
        networkManager.getCards(from: url, offset: offset) { result in
            switch result {
                
            case .success(let data):
                if let cards = try? JSONDecoder().decode([Card].self, from: data) {
                    DispatchQueue.main.async {
                        guard !cards.isEmpty else {
                            self.canLoadMore = false
                            completion()
                            return
                        }
                        if self.cards.isEmpty {
                            self.cards = cards
                            self.isLoading = false
                        } else {
                            self.cards.append(contentsOf: cards)
                            self.isLoading = false
                        }
                        completion()
                    }
                }
                
            case .failure(let failure):
                if let error = failure as? NetworkError {
                    switch error {
                        
                    case .badRequest:
                        self.onBadRequestError?()
                    case .authError:
                        self.onAuthError?()
                    case .internalServerError:
                        self.onInternalServerError?()
                    }
                }
            }
        }
    }
    
    func getNumberOfSections() -> Int {
        cards.count
    }
    
    func getCellInfo(for indexPath: IndexPath) -> Card {
        self.cards[indexPath.section]
    }
    
    func getCompanyId(for indexPath: IndexPath) -> String {
        self.cards[indexPath.section].company.companyId
    }
}
