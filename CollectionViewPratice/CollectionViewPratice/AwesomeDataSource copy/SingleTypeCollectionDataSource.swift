//
//  SingleTypeCollectionDataSource.swift
//  CollectionViewPratice
//
//  Created by Vincent Lin on 2018/6/24.
//  Copyright © 2018 Vincent Lin. All rights reserved.
//

import Foundation
import UIKit



class SingleTypeCollectionDataSource<Provider: CollectionProvider, Cell: UICollectionViewCell>:
    NSObject,
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout
where Cell: ConfigurableCell, Provider.R == Cell.R {
    
    let provider: Provider
    let collectionView: UICollectionView
    var cellType: Cell.Type?
    typealias SelectionCompletion = (IndexPath) -> ()
    typealias CellSize = (IndexPath) -> (CGSize)
    var selectedCompletion: SelectionCompletion?
    var cellSize: CellSize?
    
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.provider.numberOfSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.provider.numberOfRowInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else { return UICollectionViewCell() }
        if let item = provider.itemForIndexPath(indexPath) {
            cell.configure(item, at: indexPath)
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCompletion?(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let cellSize = cellSize {
            return cellSize(indexPath)
        } else {
            return .zero
        }
    }
}
