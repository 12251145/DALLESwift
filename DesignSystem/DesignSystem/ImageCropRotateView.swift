//
//  ImageCropRotateView.swift
//  DesignSystem
//
//  Created by Hoen on 2023/03/25.
//

import PinLayout
import UIKit

public final class ImageCropRotateView: UIView {
    private let scrollView: UIScrollView
    private let imageView: UIImageView
    private let imagePaddingView: UIView
    private let cropOverlay: UIView
    
    public var image: UIImage? {
        didSet {
            imageView.image = image
            imageView.sizeToFit()
            imagePaddingView.frame = imageView.frame

            setNeedsLayout()
        }
    }
    
    var cropSize: CGSize
    
    public init(cropSize: CGSize) {
        self.scrollView = UIScrollView()
        self.imageView = UIImageView()
        self.imagePaddingView = UIView()
        self.cropOverlay = UIView()
        self.cropSize = cropSize
        
        self.scrollView.contentInsetAdjustmentBehavior = .never
                
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        
        setUpScrollView()
        setupImageView()
        setUpCropOverlay()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
    }
    
    private func layout() {
        scrollView.pin.all()
        cropOverlay.pin.center().width(cropSize.width).height(cropSize.height)
        
        let topMargin = cropOverlay.frame.minY
        let leftMargin = cropOverlay.frame.minX
        imagePaddingView.pin.top(topMargin).left(leftMargin)
        
        let contentWidth = imagePaddingView.bounds.size.width + (scrollView.bounds.size.width - cropSize.width)
        let contentHeight = imagePaddingView.bounds.size.height + (scrollView.bounds.size.height - cropSize.height)
        scrollView.contentSize = .init(width: contentWidth, height: contentHeight)
        
        let contentOffsetX = (imagePaddingView.bounds.size.width / 2) - ((self.bounds.size.width / 2) - cropOverlay.frame.minX)
        let contentOffsetY = (imagePaddingView.bounds.size.height / 2) - ((self.bounds.size.height / 2) - cropOverlay.frame.minY)
        scrollView.contentOffset = .init(x: contentOffsetX, y: contentOffsetY)
    }
    
    private func setUpScrollView() {
        scrollView.delegate = self
                
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        addSubview(scrollView)
    }
    
    private func setupImageView() {
        imagePaddingView.addSubview(imageView)
        scrollView.addSubview(imagePaddingView)
    }

    private func setUpCropOverlay() {
        cropOverlay.isUserInteractionEnabled = false
        cropOverlay.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        cropOverlay.clipsToBounds = true
        addSubview(cropOverlay)
    }
}

// MARK: - UIScrollViewDelegate
extension ImageCropRotateView: UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        let paddingHeight = scrollView.bounds.size.height - cropSize.height
        let paddingWidth = scrollView.bounds.size.width - cropSize.width
        let origin = imagePaddingView.frame.origin
        var tmpSize = imagePaddingView.frame.size
        tmpSize.width += paddingWidth
        tmpSize.height += paddingHeight
        imagePaddingView.frame = .init(origin: origin, size: tmpSize)
        return imagePaddingView
    }
}

// MARK: - UIGestureRecognizerDelegate
extension ImageCropRotateView: UIGestureRecognizerDelegate {

    public func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        
        guard let view else { return }
        
        let currentImageWidth = imageView.frame.size.width * scale
        let currentImageHeight = imageView.frame.size.height * scale
        
        imagePaddingView.frame = .init(origin: view.frame.origin, size: .init(width: currentImageWidth, height: currentImageHeight))
        
        let contentWidth = imagePaddingView.frame.size.width + (scrollView.bounds.size.width - cropSize.width)
        let contentHeight = imagePaddingView.frame.size.height + (scrollView.bounds.size.height - cropSize.height)
        
        scrollView.contentSize = .init(width: contentWidth, height: contentHeight)        
    }
}
