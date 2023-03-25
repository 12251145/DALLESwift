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
    private let cropOverlay: UIView
    
    public var image: UIImage? {
        didSet {
            imageView.image = image
            imageView.sizeToFit()

            setNeedsLayout()
        }
    }
    
    var cropSize: CGSize
    
    public init(cropSize: CGSize) {
        self.scrollView = UIScrollView()
        self.imageView = UIImageView()
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
        imageView.pin.top(topMargin).left(leftMargin)
        
        let contentWidth = imageView.bounds.size.width + (scrollView.bounds.size.width - cropSize.width)
        let contentHeight = imageView.bounds.size.height + (scrollView.bounds.size.height - cropSize.height)
        scrollView.contentSize = .init(width: contentWidth, height: contentHeight)
        
        let contentOffsetX = (imageView.bounds.size.width / 2) - ((self.bounds.size.width / 2) - cropOverlay.frame.minX)
        let contentOffsetY = (imageView.bounds.size.height / 2) - ((self.bounds.size.height / 2) - cropOverlay.frame.minY)
        scrollView.contentOffset = .init(x: contentOffsetX, y: contentOffsetY)
    }
    
    private func setUpScrollView() {
        scrollView.delegate = self
        
        // TODO: PinchGesture도 가능하게 만들어야 함
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        addSubview(scrollView)
    }
    
    private func setupImageView() {
        scrollView.addSubview(imageView)
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
        return imageView
    }
}

// MARK: - UIGestureRecognizerDelegate

extension ImageCropRotateView: UIGestureRecognizerDelegate {
    
}
