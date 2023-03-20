//
//  NavigationTitleLabel.swift
//  DesignSystem
//
//  Created by Hoen on 2023/03/20.
//

import UIKit

public final class NavigationTitleLabel: UILabel {
    
    public init(title: String) {
        super.init(frame: .zero)
        
        self.text = title
        self.font = UIFont.boldSystemFont(ofSize: 22)
        self.textAlignment = .center
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.5
        self.numberOfLines = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
