//
//  DALLEGenerateView.swift
//  DesignSystem
//
//  Created by Hoen on 2023/03/16.
//

import PinLayout
import UIKit

final public class DALLEGenerateView: UIView {
    
    private var scrollView = ScrollView()
    public private(set) var promptView = PromptView()
    public private(set) var nStepper = NStepper(low: 1, high: 10)
    public private(set) var showPhotoPickerButton = ImageSelectButton(title: "Image to edit", guideImage: UIImage(systemName: "photo"))
    public private(set) var generateButton = CapsuleButton(title: "GENERATE")
    
    private var keyboardHeight: CGFloat = 0 {
        didSet {
            layout()
        }
    }
    
    public init() {
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }        
    
    private func configureUI() {
        addSubview(scrollView)
        addSubview(generateButton)
        
        var contentInset = UIEdgeInsets.zero
        contentInset.top = 20
        contentInset.bottom = 40
        
        scrollView.spacing = 30
        scrollView.contentInset = contentInset
        scrollView.append(promptView, 90%, 170)
        scrollView.append(nStepper, 85%, 50)
        scrollView.append(showPhotoPickerButton, 90%, 130)
    }
    
    private func layout() {
        if keyboardHeight == 0 {
            generateButton.pin.hCenter().bottom(pin.safeArea.bottom + 12).width(80%).height(50)
            scrollView.pin.above(of: generateButton).left().right().top()
            scrollView.updateHeight(promptView, 170)
            
        } else {
            generateButton.pin.hCenter().bottom(keyboardHeight + 10).width(80%).height(50)
            scrollView.pin.above(of: generateButton).left().right().top()
            scrollView.updateHeight(promptView, 150)
        }
        
    }
    
    public func adjustUIWithKeyboardHeight(_ height: CGFloat) {
        keyboardHeight = height
    }
    
    public func setImage(_ image: UIImage) {
        showPhotoPickerButton.backgroundImage = image
    }
}
