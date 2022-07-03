//
//  APIResponse.swift
//  APIPhotoSearch
//
//  Created by Наталья Шарапова on 07.03.2022.
//

import UIKit

struct APIResponse: Codable {
    
    var results: [Result]?
}

struct Result: Codable {
    let urls: URLs?
}

struct URLs: Codable {
    let regular: String?
}
