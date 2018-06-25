//
//  SingleTypeCollectionDataSource.swift
//  CollectionViewPratice
//
//  Created by Vincent Lin on 2018/6/24.
//  Copyright © 2018 Vincent Lin. All rights reserved.
//

import Foundation
import UIKit



open class SingleTypeCollectionDataSource<Provider: CollectionProvider, Cell: UICollectionViewCell>:
    NSObject,
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout
where Cell: ConfigurableCell, Provider.R == Cell.R {
    
    let provider: Provider
    let collectionView: UICollectionView
    var cellType: Cell.Type?
    public typealias SelectionCompletion = (IndexPath, Provider.R?, Cell?) -> Void
    public typealias CellSize = (IndexPath) -> (CGSize)
    public typealias MinimumLineSpacingForSection = (Int) -> CGFloat
    public typealias MinimumInteritemSpacingForSection = (Int) -> CGFloat
    public typealias InsetForSection = (Int) -> UIEdgeInsets
    public var selectedCompletion: SelectionCompletion?
    public var cellSize: CellSize?
    public var minimumLineSpacingForSection: MinimumLineSpacingForSection?
    public var minimumInteritemSpacingForSection: MinimumInteritemSpacingForSection?
    public var insetForSection: InsetForSection?
    
    init(collectionView: UICollectionView, provider: Provider) {
        self.provider = provider
        self.collectionView = collectionView
        self.cellType = Cell.self
        super.init()
        self.setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @discardableResult
    public func updateMinimumLineSpacingForSection(_ minimum: @escaping MinimumLineSpacingForSection) -> Self {
        self.minimumLineSpacingForSection = minimum
        return self
    }
    
    @discardableResult
    public func updateMinimumInteritemSpacingForSection(_ minimum: @escaping MinimumInteritemSpacingForSection) -> Self {
        self.minimumInteritemSpacingForSection = minimum
        return self
    }
    
    @discardableResult
    public func updateInsetForSection(_ inset: @escaping InsetForSection) -> Self {
        self.insetForSection = inset
        return self
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.provider.numberOfSection()
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.provider.numberOfRowInSection(section)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else { return UICollectionViewCell() }
        if let item = provider.itemForIndexPath(indexPath) {
            cell.configure(item, at: indexPath)
        }
        
        return cell
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCompletion?(indexPath, provider.itemForIndexPath(indexPath), collectionView.cellForItem(at: indexPath) as? Cell)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let cellSize = cellSize {
            return cellSize(indexPath)
        } else {
            return .zero
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if let minimum = minimumLineSpacingForSection {
            return minimum(section)
        } else {
            return 0
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if let minimum = minimumInteritemSpacingForSection {
            return minimum(section)
        } else {
            return 0.0
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if let inset = self.insetForSection {
            return inset(section)
        } else {
            return UIEdgeInsets.zero
        }
    }
}
