//
//  RequestHeader.swift
//  TechTask-CardsApp
//
//  Created by Анатолий Силиверстов on 15.04.2023.
//

import Foundation

struct Header: Codable {
    let key: String
    let value: String
}

extension Header {
    static var requestHeader: Header {
        Header(key: "TOKEN", value: "123")
    }
}
