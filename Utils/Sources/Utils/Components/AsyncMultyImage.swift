//
//  AsyncMultyImage.swift
//  Utils
//
//  Created by Александр Мельников on 21.12.2025.
//

import SwiftUI

public struct AsyncMultiImage<Placeholder: View, ErrorView: View>: View {
    private let url: URL?
    private let width: CGFloat?
    private let height: CGFloat?
    private let placeholder: Placeholder
    private let errorView: ErrorView
    
    public init(
        url: URL?,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        @ViewBuilder placeholder: () -> Placeholder = { ProgressView() },
        @ViewBuilder errorView: () -> ErrorView = { Image(systemName: "photo") }
    ) {
        self.url = url
        self.width = width
        self.height = height
        self.placeholder = placeholder()
        self.errorView = errorView()
    }
    
    public var body: some View {
        Group {
            if let url = url {
                if url.absoluteString.hasSuffix(".svg") {
                    WebView(url: url)
                        .aspectRatio(contentMode: .fit)
                } else {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let image):
                            image.resizable().aspectRatio(contentMode: .fit)
                        case .failure:
                            errorView
                        default:
                            placeholder
                        }
                    }
                }
            }
        }
        .frame(width: width, height: height)
    }
}
