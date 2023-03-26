//
//  ImageCropRotateView.swift
//  DesignSystem
//
//  Created by Hoen on 2023/03/25.
//

import PinLayout
import UIKit

public final class ImageCropRotateView: UIView {
    private let scrollView = UIScrollView()
    private let imageView = UIImageView()
    private let imagePaddingView = UIView()
    private let blurWithClearMaskView = BlurWithClearMaskView(blurEffect: .systemUltraThinMaterialDark)
    private let cropOverlay = UIView()
    private let cropFocusBorder = CropAreaFocusBorder(lineWidth: 2)
    private let doneButton = CapsuleButton(title: "Done", backgroundColor: .white, foregroundColor: .black, fontWeight: .semibold)
    private let xButton = XButton(xSize: 15, xColor: .white, backgroundColor: .black)
    private let titleLabel = NavigationTitleLabel(title: "Image Crop")

    public var image: UIImage? {
        didSet {
            imageView.image = image
            imageView.sizeToFit()
            fitImageViewSizeToCrop()
            imagePaddingView.frame = imageView.frame

            setNeedsLayout()
        }
    }
    
    private var cropSize: CGSize
    
    private var isInitLayout: Bool = true
    
    public init(cropSize: CGSize) {
        self.cropSize = cropSize
        super.init(frame: .zero)
                
        self.scrollView.contentInsetAdjustmentBehavior = .never
        self.backgroundColor = .black
        
        setUpScrollView()
        setUpImageView()
        setUpBlurMask()
        setUpCropOverlay()
        setUpdoneButton()
        setUpXButton()
        setUpTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
    }
    
    private func layout() {
        
        guard isInitLayout else { return }
        isInitLayout = false
        
        scrollView.pin.all()
        blurWithClearMaskView.pin.all()
        
        cropOverlay.pin.hCenter().vCenter(-7%).width(cropSize.width).height(cropSize.height)
        cropFocusBorder.pin.all(-cropFocusBorder.lineWidth)
        cropFocusBorder.setNeedsDisplay()
        
        blurWithClearMaskView.clearArea = cropOverlay.frame
        
        let topMargin = cropOverlay.frame.minY
        let leftMargin = cropOverlay.frame.minX
        imagePaddingView.pin.top(topMargin).left(leftMargin)
        
        let contentWidth = imagePaddingView.bounds.size.width + (scrollView.bounds.size.width - cropSize.width)
        let contentHeight = imagePaddingView.bounds.size.height + (scrollView.bounds.size.height - cropSize.height)
        scrollView.contentSize = .init(width: contentWidth, height: contentHeight)
        
        doneButton.pin.hCenter().bottom(pin.safeArea.bottom).width(100).height(40).marginBottom(70)
        xButton.pin.top(pin.safeArea.top).right(20).marginTop(20).width(40).height(40)
        xButton.layer.cornerRadius = xButton.bounds.size.height / 2
        
        titleLabel.pin.hCenter().before(of: xButton, aligned: .center).width(100).height(50)
        
    }
    
    private func setUpScrollView() {
        scrollView.delegate = self
                
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        addSubview(scrollView)
    }
    
    private func setUpImageView() {
        imageView.contentMode = .scaleAspectFill
        imagePaddingView.addSubview(imageView)
        scrollView.addSubview(imagePaddingView)
    }

    private func setUpCropOverlay() {
        cropOverlay.isUserInteractionEnabled = false
        cropOverlay.layer.addSublayer(cropFocusBorder)
        cropOverlay.layer.borderColor = UIColor.white.cgColor
        cropOverlay.layer.borderWidth = 1
        cropFocusBorder.contentsScale = UIScreen.main.scale
        
        addSubview(cropOverlay)
    }
    
    private func setUpBlurMask() {
        blurWithClearMaskView.isUserInteractionEnabled = false
        addSubview(blurWithClearMaskView)
    }
    
    private func setUpdoneButton() {
        addSubview(doneButton)
    }
    
    private func setUpXButton() {
        addSubview(xButton)
    }
    
    private func setUpTitleLabel() {
        titleLabel.textColor = .white
        addSubview(titleLabel)
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
        
        // TODO: 매직넘버 0.1 수정 해야 함. 사이즈 딱 맞을 때 바운스 안되는 문제 때문에 있는 것임.
        scrollView.contentSize = .init(width: contentWidth + 0.1, height: contentHeight + 0.1)
    }
}

// MARK: - Private functions
private extension ImageCropRotateView {
    func fitImageViewSizeToCrop() {
        let imageViewWidth = imageView.frame.size.width
        let imageViewHeight = imageView.frame.size.height
        let smallSide = imageViewWidth < imageViewHeight ? imageViewWidth : imageViewHeight
        let ratio = cropSize.width / smallSide
        
        let fitWidth = ratio * imageViewWidth
        let fitHeight = ratio * imageViewHeight
        
        // TODO: 매직넘버 0.1 수정 해야 함. 사이즈 딱 맞을 때 바운스 안되는 문제 때문에 있는 것임.
        imageView.frame = .init(x: 0, y: 0, width: fitWidth + 0.1, height: fitHeight + 0.1)
    }
}
