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
    public typealias SelectionCompletion = (IndexPath, Provider.R?, Cell?) -> ()
    public typealias CellSize = (IndexPath) -> (CGSize)
    public var selectedCompletion: SelectionCompletion?
    public var cellSize: CellSize?
    
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
}
