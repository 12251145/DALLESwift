//
//  GridView.swift
//  DesignSystem
//
//  Created by Hoen on 2023/03/23.
//

import UIKit

public final class GridView: UICollectionView {

    public init(itemSize: NSCollectionLayoutSize, direction: UICollectionView.ScrollDirection) {
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = direction
        
        let layout = UICollectionViewCompositionalLayout(
            sectionProvider: { _, _ in
                
                let item = NSCollectionLayoutItem(
                    layoutSize: itemSize
                )
                
                if direction == .vertical {
                    let groupSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: itemSize.heightDimension
                    )
                    
                    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                    
                    return NSCollectionLayoutSection(group: group)
                } else {
                    let groupSize = NSCollectionLayoutSize(
                        widthDimension: itemSize.widthDimension,
                        heightDimension: .fractionalHeight(1)
                    )
                    
                    let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                    
                    return NSCollectionLayoutSection(group: group)
                }
            },
            configuration: config
        )
        
        super.init(frame: .zero, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
