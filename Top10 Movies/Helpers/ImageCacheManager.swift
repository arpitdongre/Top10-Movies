//
//  ImageCacheManager.swift
//  Top10 Movies
//
//  Created by Arpit Dongre on 12/11/24.
//

import SwiftUI

class ImageCacheManager {
    static let shared = ImageCacheManager()
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getImage(for url: URL) -> UIImage? {
        return cache.object(forKey: url.absoluteString as NSString)
    }
    
    func saveImage(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url.absoluteString as NSString)
    }
}

struct AsyncCachedImage: View {
    let url: URL
    @State private var loadedImage: UIImage? = nil
    @State private var isLoading = false
    let placeholder: AnyView
    let errorImage: AnyView

    init(url: URL, placeholder: AnyView = AnyView(ProgressView()), errorImage: AnyView = AnyView(Image(systemName: "exclamationmark.triangle.fill").foregroundColor(.red))) {
        self.url = url
        self.placeholder = placeholder
        self.errorImage = errorImage
    }
    
    var body: some View {
        Group {
            if let image = loadedImage {
                Image(uiImage: image)
                    .resizable()
            } else if isLoading {
                placeholder
            } else {
                errorImage
            }
        }
        .onAppear {
            loadImage()
        }
    }
    
    private func loadImage() {
        if let cachedImage = ImageCacheManager.shared.getImage(for: url) {
            loadedImage = cachedImage
        } else {
            isLoading = true
            downloadImage()
        }
    }
    
    private func downloadImage() {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.loadedImage = nil
                }
                return
            }
            ImageCacheManager.shared.saveImage(image, for: url)
            DispatchQueue.main.async {
                self.loadedImage = image
                self.isLoading = false
            }
        }
        .resume()
    }
}
