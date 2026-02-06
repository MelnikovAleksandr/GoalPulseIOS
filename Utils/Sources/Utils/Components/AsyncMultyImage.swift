//
//  AsyncMultyImage.swift
//  Utils
//
//  Created by Александр Мельников on 21.12.2025.
//

import SwiftUI
import DominantColors

public struct AsyncMultiImage<Placeholder: View, ErrorView: View>: View {
    private let url: URL?
    private let extractColors: Bool
    private let placeholder: Placeholder
    private let errorView: ErrorView
    private let onColorsExtracted: (([Color]) -> Void)?
    
    public init(
        url: URL?,
        extractColors: Bool = false,
        @ViewBuilder placeholder: () -> Placeholder = { ProgressView() },
        @ViewBuilder errorView: () -> ErrorView = { Image(systemName: "photo") },
        onColorsExtracted: (([Color]) -> Void)? = nil
    ) {
        self.url = url
        self.extractColors = extractColors
        self.placeholder = placeholder()
        self.errorView = errorView()
        self.onColorsExtracted = onColorsExtracted
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
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .task(id: url) {
                                    if extractColors {
                                        await extractColors(from: url)
                                    }
                                }
                        case .failure:
                            errorView
                        default:
                            placeholder
                        }
                    }
                }
            }
        }
    }
    
    private func extractColors(from url: URL) async {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let uiImage = UIImage(data: data) else { return }
            let uiColors = try DominantColors.dominantColors(uiImage: uiImage, quality: .low, algorithm: .euclidean, maxCount: 3)
            let colors = uiColors.map(Color.init)
            Task {
                onColorsExtracted?(colors)
            }
        } catch {
            print("❌ Extract colors error: \(error)")
        }
    }
}
