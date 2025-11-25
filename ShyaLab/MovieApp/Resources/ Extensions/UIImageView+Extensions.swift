//
//  UIImageView+Extensions.swift
//  MovieApp
//
//  Created by Shrouk Yasser on 25/11/2025.
//

import UIKit

// MARK: - Protocol
protocol ImageDownloaded {
    func setImage(urlStr: String?, placeholder: UIImage?)
}

// MARK: - Associated Keys
private var taskKey: Void?
private var spinnerKey: Void?

extension UIImageView: ImageDownloaded {
    
    // MARK: - Properties to mimic Kingfisher behavior
   private var currentTask: Task<Void, Never>? {
        get { return objc_getAssociatedObject(self, &taskKey) as? Task<Void, Never> }
        set { objc_setAssociatedObject(self, &taskKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    private var spinner: UIActivityIndicatorView? {
        get { return objc_getAssociatedObject(self, &spinnerKey) as? UIActivityIndicatorView }
        set { objc_setAssociatedObject(self, &spinnerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    // MARK: - Main Function
    
    func setImage(urlStr: String?, placeholder: UIImage? = nil) {
        currentTask?.cancel()
        
       self.image = placeholder
        
        guard let urlStr = urlStr, let _ = URL(string: urlStr) else { return }
        
        showSpinner()
        
        currentTask = Task { @MainActor in
            let loadedImage = await ImageLoader.shared.loadImage(from: urlStr)
            
           if !Task.isCancelled {
                self.hideSpinner()
               UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve) {
                    self.image = loadedImage
                }
            }
        }
    }
    
    // MARK: - Private Helper (Spinner Logic)
    
    private func showSpinner() {
        if spinner == nil {
            let indicator = UIActivityIndicatorView(style: .medium)
            indicator.hidesWhenStopped = true
            indicator.color = .gray
            self.addSubview(indicator)
            
           indicator.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
            self.spinner = indicator
        }
        spinner?.startAnimating()
    }
    
    private func hideSpinner() {
        spinner?.stopAnimating()
    }
}
