//
//  ImageSelectButton.swift
//  DesignSystem
//
//  Created by Hoen on 2023/03/22.
//

import PinLayout
import UIKit

public final class ImageSelectButton: UIView {
    
    private enum Mode {
        case image
        case noImage
        case processing
    }
    
    public private(set) var button = UIButton()
    public private(set) var imageView = UIImageView()
    private let borderLayer = CAShapeLayer()
    private let processingBlurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialLight))
    public private(set) var xButton = XButton(xSize: 12, xColor: .black, effectStyle: .regular)
    public private(set) var editMaskButton = CapsuleButton(
        title: "Mask",
        symbolName: "moonphase.waxing.gibbous"
    )
    
    public var backgroundImage: UIImage? {
        didSet {
            if backgroundImage == nil {
                mode = .noImage
            } else {
                mode = isProcessing ? .processing : .image
            }
        }
    }
    
    public var isProcessing = false {
        didSet {
            if isProcessing {
                mode = .processing
            } else {
                mode = backgroundImage == nil ? .noImage : .image
            }
        }
    }
    
    private let title: String
    private let guideImage: UIImage?
    
    private var mode: Mode = .noImage {
        didSet {
            configure()
        }
    }
    
    public init(title: String, guideImage: UIImage? = nil) {
        
        self.title = title
        self.guideImage = guideImage
        
        super.init(frame: .zero)
        
        self.clipsToBounds = true
        
        addSubview(imageView)
        addSubview(button)
        addSubview(xButton)
        addSubview(editMaskButton)
        addSubview(processingBlurView)
        
        
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerCurve = .continuous
                
        imageView.pin.all()
        button.pin.all()
        updateBorderPath()
        xButton.pin.topRight(15).width(30).height(30)
        xButton.layer.cornerRadius = xButton.bounds.size.height / 2
        editMaskButton.pin.bottomRight(15).width(100).height(36)
        processingBlurView.pin.all()
    }
    
    private func updateBorderPath() {

        let borderPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius)
        borderLayer.path = borderPath.cgPath

    }
    
    private func configure() {
        setBorderLayer()
        setButton()
        setImageView()
        setXButton()
        setEditMaskButton()
        setProcessingBlur()
    }
    
    private func setBorderLayer() {
        
        updateBorderPath()
        
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = mode == .noImage ? UIColor.black.cgColor : UIColor.clear.cgColor
        borderLayer.lineWidth = 2.0
        borderLayer.lineCap = .round
        
        borderLayer.lineDashPattern = [7, 10]
        
        layer.addSublayer(borderLayer)
    }
    
    private func setButton() {
        var config = button.configuration ?? UIButton.Configuration.filled()
        
        config.baseBackgroundColor = mode == .noImage ? .systemGray6 : .clear
        config.image = mode == .noImage ? guideImage : nil
        config.title = mode == .noImage ? title : nil
        config.baseForegroundColor = .darkGray
        config.imagePadding = 10
        
        button.configuration = config
    }
    
    private func setImageView() {
        
        imageView.contentMode = .scaleAspectFill
        imageView.image = backgroundImage
    }
    
    private func setXButton() {
        xButton.isHidden = mode == .noImage ? true : false
    }
    
    private func setEditMaskButton() {
        editMaskButton.isHidden = mode == .noImage ? true: false
    }
    
    private func setProcessingBlur() {
        processingBlurView.isHidden = !isProcessing
    }
}
