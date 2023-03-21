//
//  ScrollView.swift
//  DesignSystem
//
//  Created by Hoen on 2023/03/21.
//

import PinLayout
import UIKit

public final class ScrollView: UIView {
    
    private struct ContentInfo {
        var view: UIView
        var wCGFloat: CGFloat?
        var wPercent: Percent?
        var height: CGFloat
        
        init(view: UIView, wCGFloat: CGFloat?, height: CGFloat) {
            self.view = view
            self.wCGFloat = wCGFloat
            self.height = height
        }
        
        init(view: UIView, wPercent: Percent?, height: CGFloat) {
            self.view = view
            self.wPercent = wPercent
            self.height = height
        }
    }

    let scrollView = UIScrollView()
    
    public var spacing: CGFloat = 0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    private var contents: [ContentInfo] = []
    private var contentsDict: [UIView: Int] = [:]

    public init() {
        super.init(frame: .zero)
        self.addSubview(scrollView)
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.contentInset.top = 1
        
        self.layer.masksToBounds = false
        self.scrollView.layer.masksToBounds = false
        
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
        
        var top: CGFloat = 0
        let scrollViewHeight = scrollView.bounds.size.height
                
        scrollView.subviews.forEach { subview in
            if let index = contentsDict[subview] {
                let height = contents[index].height
                
                if let width = contents[index].wCGFloat {
                    subview.pin.top(top).hCenter().width(width).height(height)
                } else if let width = contents[index].wPercent {
                    subview.pin.top(top).hCenter().width(width).height(height)
                }
                
                top += height + spacing
            }
        }
        
        top -= top == 0 ? 0 : spacing
        scrollView.contentSize.height = max(scrollViewHeight, top)
        
        scrollView.layoutIfNeeded()
    }
    
    public func append(_ view: UIView, _ width: CGFloat, _ height: CGFloat) {
        scrollView.addSubview(view)
        contents.append(ContentInfo(view: view, wCGFloat: width, height: height))
        contentsDict[view] = contents.count - 1
    }
    
    public func append(_ view: UIView, _ width: Percent, _ height: CGFloat) {
        scrollView.addSubview(view)
        contents.append(ContentInfo(view: view, wPercent: width, height: height))
        contentsDict[view] = contents.count - 1
    }
    
    public func updateHeight(_ view: UIView, _ height: CGFloat) {
        guard let index = contentsDict[view] else { return }
        
        var info = contents[index]
        info.height = height
        
        contents[index] = info
        
        layout()
    }
}
