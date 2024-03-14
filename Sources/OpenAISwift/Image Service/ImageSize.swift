//
//  ImageSize.swift
//  
//
//  Created by Clay Suttner on 3/13/24.
//

import Foundation

public enum ImageSize: String, Encodable {
    
    /// 256 x 256
    case smallSquare = "256x256"
    
    /// 512 x 512
    case mediumSquare = "512x512"
    
    /// 1024 x 1024
    case largeSquare = "1024x1024"
    
    /// 1792 x 1024
    case largeRectLandscape = "1792x1024"
    
    /// 1024 x 1792
    case largeRectPortrait = "1024x1792"
}
