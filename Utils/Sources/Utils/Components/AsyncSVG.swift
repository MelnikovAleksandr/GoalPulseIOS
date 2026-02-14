//
//  AsyncSVG.swift
//  Utils
//
//  Created by Александр Мельников on 19.12.2025.
//

import SwiftUI
import SDWebImageSVGCoder
import SDWebImageSwiftUI

public class SVGHelper {
    public static func setUpDependencies() {
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
    }
}

public struct WebView: View {
    let url: URL?
    
    public init(url: URL?) {
        self.url = url
    }
    
    public var body: some View {
        WebImage(url: url, options: [], context: [.imageThumbnailPixelSize : CGSize.zero])
            .resizable()
    }
}
