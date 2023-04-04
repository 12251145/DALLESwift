//
//  CenteredPagingCollectionView.swift
//  DesignSystem
//
//  Created by Hoen on 2023/04/04.
//

import UIKit

public final class CenteredPagingCollectionView: UICollectionView {
    
    public init(width: CGFloat, height: CGFloat) {
        
        let layout = UICollectionViewCompositionalLayout { _, env in
            
            let inset = max((env.container.contentSize.width - width) / 2, 0)
                        
            let item = NSCollectionLayoutItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            
            let groupWidth = env.container.contentSize.width - (inset * 2)
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .absolute(groupWidth),
                heightDimension: .absolute(height)
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            section.interGroupSpacing = inset / 2
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: inset, bottom: 0, trailing: inset)
            
            return section
        }
        
        super.init(frame: .zero, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
