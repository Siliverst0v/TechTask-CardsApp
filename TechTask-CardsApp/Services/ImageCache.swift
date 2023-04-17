//
//  ImageCache.swift
//  TechTask-CardsApp
//
//  Created by Анатолий Силиверстов on 17.04.2023.
//

import UIKit

final class ImageCache {
    
    private init() {}
    
    static let shared = NSCache<NSString, UIImage>()
}
