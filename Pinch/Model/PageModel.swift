//
//  PageModel.swift
//  Pinch
//
//  Created by Reza on 21/7/2024.
//

import Foundation

struct Page: Identifiable {
    let id: Int
    let imageName: String
}

extension Page {
    var thumbnailName: String {
        return "thumb-" + imageName
    }
}
