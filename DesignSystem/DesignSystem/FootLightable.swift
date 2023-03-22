//
//  FootLightable.swift
//  DesignSystem
//
//  Created by Hoen on 2023/03/22.
//

import PinLayout
import UIKit

public protocol FootLightable: AnyObject where Self: UIView {
    var footLight: FootLightView { get set }
    
    func addLight()
    func removeLight()
    func layoutAll()    
    func layoutOthers()
}

public extension FootLightable {
    
    func addLight() {
        self.addSubview(footLight)
    }
    
    func removeLight() {
        footLight.removeFromSuperview()
    }
    
    func layoutAll() {
        layoutOthers()
        layoutFootLight()
    }
    
    func layoutFootLight() {
        footLight.pin.bottom().left().right()
    }
    
    func layoutOthers() {
        fatalError("Should layout other contents")
    }
}
