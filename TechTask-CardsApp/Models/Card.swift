//
//  Card.swift
//  TechTask-CardsApp
//
//  Created by Анатолий Силиверстов on 15.04.2023.
//

import Foundation

struct Card: Codable {
    let company: Company
    let customerMarkParameters: CustomerMarkParameters
    let mobileAppDashboard: MobileAppDashboard
}

struct Company: Codable {
    let companyId: String
}

struct CustomerMarkParameters: Codable {
    let loyaltyLevel: LoyaltyLevel
    let mark: Int
}

struct LoyaltyLevel: Codable {
    let number: Int
    let name: String
    let requiredSum: Int
    let markToCash: Int
    let cashToMark: Int
}

struct MobileAppDashboard: Codable {
    let companyName: String
    let logo: String
    let backgroundColor: String
    let mainColor: String
    let cardBackgroundColor: String
    let textColor: String
    let highlightTextColor: String
    let accentColor: String
}
