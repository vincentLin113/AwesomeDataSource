//
//  BaseCollectionCell.swift
//  CollectionViewPratice
//
//  Created by Vincent Lin on 2018/6/24.
//  Copyright © 2018 Vincent Lin. All rights reserved.
//

import Foundation
import UIKit

open class BaseCollectionCell: UICollectionViewCell {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupViews() {}
}

open class GenericCell<DataType>: BaseCollectionCell, ConfigurableCell {
    
    var item: DataType?
    
    public func configure(_ item: DataType, at indexPath: IndexPath) {
        self.item = item
    }
}
