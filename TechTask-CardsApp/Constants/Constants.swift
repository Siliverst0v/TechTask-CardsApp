//
//  Constants.swift
//  TechTask-CardsApp
//
//  Created by Анатолий Силиверстов on 15.04.2023.
//

import UIKit

enum StringConstants {
    static let cardManagment = "Управление картами"
    static let moreButtonTitle = "Подробнее"
    static let marks = "баллов"
    static let cashBack = "Кешбэк"
    static let level = "Уровень"
    static let loading = "Подгрузка компаний"
    static let error = "Ошибка"
    static let authError = "Ошибка авторизации"
    static let serverError = "Все упало"
    static let eyeButtonTaped = "Нажата кнопка Eye, id компании:"
    static let trashButtonTapped = "Нажата кнопка Trash, id компании:"
    static let moreButtonTapped = "Нажата кнопка Подробнее, id компании:"
    static let url = "http://dev.bonusmoney.pro/mobileapp/getAllCompaniesError"
}

enum Images {
    static let eye = UIImage(named: "eye")
    static let trash = UIImage(named: "trash")
}

enum Colors {
    static let white = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    static let black = UIColor(red: 26/255, green: 26/255, blue: 26/255, alpha: 1)
    static let red = UIColor(red: 255/255, green: 48/255, blue: 68/255, alpha: 1)
    static let blue = UIColor(red: 38/255, green: 136/255, blue: 235/255, alpha: 1)
    static let darkGrey = UIColor(red: 148/255, green: 148/255, blue: 148/255, alpha: 1)
    static let lightGrey = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1)
}

enum Fonts {
    static let small = UIFont.systemFont(ofSize: 14)
    static let medium = UIFont.systemFont(ofSize: 17)
    static let large = UIFont.systemFont(ofSize: 20)
}

enum NetworkError: Error {
    case authError
    case badRequest
    case internalServerError
}
