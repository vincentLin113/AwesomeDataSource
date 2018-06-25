//
//  ArrayDataSource.swift
//  CollectionViewPratice
//
//  Created by Vincent Lin on 2018/6/24.
//  Copyright © 2018 Vincent Lin. All rights reserved.
//

import Foundation
import UIKit

class ArrayDataSource<T, R, Cell>:SingleTypeCollectionDataSource<SectionTypeDataProvider<T, R>, Cell>
    where Cell: ConfigurableCell, Cell:UICollectionViewCell, Cell.R == R, T: SectionModel, R: RowModel
{
    public init(collectionView: UICollectionView, singleSectionData: T) {
        let provider = SectionTypeDataProvider<T, R>.init(data: [singleSectionData])
        super.init(collectionView: collectionView, provider: provider)
    }
    
    public init(collectionView: UICollectionView, sectionData: [T]) {
        let provider = SectionTypeDataProvider<T, R>.init(data: sectionData)
        super.init(collectionView: collectionView, provider: provider)
    }
    
    public func itemCellRow(_ indexPath: IndexPath) -> R? {
        return provider.itemForIndexPath(indexPath)
    }
    
    public func update(_ indexPath: IndexPath, value: T) {
        provider.updateData(in: indexPath, value: value)
    }
}
