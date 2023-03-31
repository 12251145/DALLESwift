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
    }
    
    public private(set) var button = UIButton()
    private let imageView = UIImageView()
    private let borderLayer = CAShapeLayer()
    private let xButton = XButton(xSize: 12, xColor: .black, effectStyle: .regular)
    
    public var backgroundImage: UIImage? {
        didSet {
            mode = backgroundImage == nil ? .noImage : .image
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
        
        xButton.button.addAction(
            .init(handler: { [weak self] _ in
                self?.backgroundImage = nil
            }),
            for: .touchUpInside
        )
        
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerCurve = .continuous
        self.layer.cornerRadius = self.bounds.size.height * 0.2
                
        imageView.pin.all()
        button.pin.all()
        updateBorderPath()
        xButton.pin.topRight(15).width(30).height(30)
        
        xButton.layer.cornerRadius = xButton.bounds.size.height / 2
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
        imageView.image = mode == .noImage ? nil : backgroundImage
    }
    
    private func setXButton() {
        xButton.isHidden = mode == .noImage ? true : false
    }
}
