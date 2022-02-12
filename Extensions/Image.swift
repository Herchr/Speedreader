//
//  Image.swift
//  Speedreader
//
//  Created by Herman Christiansen on 10/01/2022.
//

import SwiftUI

extension Image {

    public init(data: Data?, placeholder: String) {
        guard let data = data,
          let uiImage = UIImage(data: data) else {
            self = Image(placeholder)
            return
        }
        self = Image(uiImage: uiImage)
    }
}
