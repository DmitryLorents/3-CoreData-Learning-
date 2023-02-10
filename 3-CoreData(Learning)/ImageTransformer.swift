//
//  ImageTransformer.swift
//  3-CoreData(Learning)
//
//  Created by Mac on 10.02.2023.
//

import UIKit

class ImageTransformer: ValueTransformer {

    override func transformedValue(_ value: Any?) -> Any? {
        guard let image = value as? UIImage else {return nil}
        let data = image.pngData()
        return data
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let imageData = value as? Data else {return nil}
        return UIImage(data: imageData)
    }
    
}
