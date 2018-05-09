//
//  StrechyHeaderLayout.swift
//  KURSOVAYA_PATRIA
//
//  Created by Vasile Morari on 5/9/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import Foundation
import UIKit

class StretchyHeaderLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)! as [UICollectionViewLayoutAttributes]
        headerReferenceSize.height = 110
        let insets = collectionView!.contentInset
        let offset = collectionView!.contentOffset
        let minY = -insets.top
        if (offset.y < minY) {
            let deltaY = fabs(offset.y - minY)
            for attributes in layoutAttributes {
                if let elementKind = attributes.representedElementKind {
                    if elementKind == UICollectionElementKindSectionHeader {
                        var frame = attributes.frame
                        frame.size.height = max(minY, headerReferenceSize.height + deltaY)
                        frame.origin.y = frame.minY - deltaY
                        attributes.frame = frame
                    }
                }
            }
        }
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
