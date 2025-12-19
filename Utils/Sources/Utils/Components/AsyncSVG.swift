//
//  AsyncSVG.swift
//  Utils
//
//  Created by Александр Мельников on 19.12.2025.
//

import Foundation
import UIKit
import SwiftUI

public struct AsyncSVGImage<Content, Placeholder>: View where Content: View, Placeholder: View {
    private let url: URL?
    private let content: (Image) -> Content
    private let placeholder: Placeholder

    @State private var uiImage: UIImage?
    public init(url: URL?, @ViewBuilder content: @escaping (Image) -> Content, @ViewBuilder placeholder: @escaping () -> Placeholder) {
        self.url = url
        self.content = content
        self.placeholder = placeholder()
    }

    @MainActor public var body: some View {
        content(
            Image(uiImage: uiImage ?? UIImage())
        )
        .overlay {
            placeholder
                .opacity(uiImage == nil ? 1.0 : 0.0)
                .disabled(uiImage == nil)
        }
        .onAppear {
            loadImageIfPossible()
        }
    }

    private func loadImageIfPossible() {
        guard let url else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard
                let data,
                error == nil,
                let svg = SVG(data)
            else { return }

            let render = UIGraphicsImageRenderer(size: svg.size)
            uiImage = render.image { context in
                svg.draw(in: context.cgContext)
            }
        }.resume()
    }
}

@objc
final fileprivate class CGSVGDocument: NSObject {}

fileprivate let CGSVGDocumentRetain: (@convention(c) (CGSVGDocument?) -> Unmanaged<CGSVGDocument>?) = load("CGSVGDocumentRetain")
fileprivate let CGSVGDocumentRelease: (@convention(c) (CGSVGDocument?) -> Void) = load("CGSVGDocumentRelease")
fileprivate let CGSVGDocumentCreateFromData: (@convention(c) (CFData?, CFDictionary?) -> Unmanaged<CGSVGDocument>?) = load("CGSVGDocumentCreateFromData")
fileprivate let CGContextDrawSVGDocument: (@convention(c) (CGContext?, CGSVGDocument?) -> Void) = load("CGContextDrawSVGDocument")
fileprivate let CGSVGDocumentGetCanvasSize: (@convention(c) (CGSVGDocument?) -> CGSize) = load("CGSVGDocumentGetCanvasSize")

fileprivate typealias ImageWithCGSVGDocument = @convention(c) (AnyObject, Selector, CGSVGDocument) -> UIImage
fileprivate let ImageWithCGSVGDocumentSEL: Selector = NSSelectorFromString("_imageWithCGSVGDocument:")

nonisolated(unsafe) fileprivate let CoreSVG = dlopen("/System/Library/PrivateFrameworks/CoreSVG.framework/CoreSVG", RTLD_NOW)

fileprivate func load<T>(_ name: String) -> T {
    unsafeBitCast(dlsym(CoreSVG, name), to: T.self)
}

final fileprivate class SVG {
    deinit { CGSVGDocumentRelease(document) }

    let document: CGSVGDocument

    convenience init?(_ value: String) {
        guard let data = value.data(using: .utf8) else { return nil }
        self.init(data)
    }

    init?(_ data: Data) {
        guard let document = CGSVGDocumentCreateFromData(data as CFData, nil)?.takeUnretainedValue() else { return nil }
        guard CGSVGDocumentGetCanvasSize(document) != .zero else { return nil }
        self.document = document
    }

    var size: CGSize {
        CGSVGDocumentGetCanvasSize(document)
    }

    func image() -> UIImage? {
        let ImageWithCGSVGDocument = unsafeBitCast(UIImage.method(for: ImageWithCGSVGDocumentSEL), to: ImageWithCGSVGDocument.self)
        let image = ImageWithCGSVGDocument(UIImage.self, ImageWithCGSVGDocumentSEL, document)
        return image
    }

    func draw(in context: CGContext) {
        draw(in: context, size: size)
    }

    func draw(in context: CGContext, size target: CGSize) {
        var target = target

        let ratio = (
            x: target.width / size.width,
            y: target.height / size.height
        )

        let rect = (
            document: CGRect(origin: .zero, size: size), ()
        )

        let scale: (x: CGFloat, y: CGFloat)

        if target.width <= 0 {
            scale = (ratio.y, ratio.y)
            target.width = size.width * scale.x
        } else if target.height <= 0 {
            scale = (ratio.x, ratio.x)
            target.width = size.width * scale.y
        } else {
            let min = min(ratio.x, ratio.y)
            scale = (min, min)
            target.width = size.width * scale.x
            target.height = size.height * scale.y
        }

        let transform = (
            scale: CGAffineTransform(scaleX: scale.x, y: scale.y),
            aspect: CGAffineTransform(translationX: (target.width / scale.x - rect.document.width) / 2, y: (target.height / scale.y - rect.document.height) / 2)
        )

        context.translateBy(x: 0, y: target.height)
        context.scaleBy(x: 1, y: -1)
        context.concatenate(transform.scale)
        context.concatenate(transform.aspect)

        CGContextDrawSVGDocument(context, document)
    }
}
