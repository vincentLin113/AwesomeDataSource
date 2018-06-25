//
//  SingleTypeDataProvider.swift
//  CollectionViewPratice
//
//  Created by Vincent Lin on 2018/6/24.
//  Copyright © 2018 Vincent Lin. All rights reserved.
//

import Foundation
import UIKit

class SectionTypeDataProvider<T, R>: CollectionProvider
    where T: SectionModel, R: RowModel
{
    //    typealias T = DataType
    private var data: [T]
    
    init(data: [T]) {
        self.data = data
    }
    
    func numberOfSection() -> Int {
        return data.count
    }
    
    func numberOfRowInSection(_ section: Int) -> Int {
        if let sectionModel = data[safe: section] {
            return sectionModel.numberOfRow
        } else {
            return 0
        }
    }
    
    func itemForIndexPath(_ indexPath: IndexPath) -> R? {
        return data[safe: indexPath.section]?.row(in: indexPath.item) as? R
    }
    
    func updateData(in indexPath: IndexPath, value: T) {
//        if data.count < indexPath.section, data[indexPath.section].count < indexPath.item {
//            data[indexPath.section][indexPath.item] = value
//        }
    }
    
}


extension Array {
    public subscript (safe safe: Int) -> Element? {
        if self.count > safe {
            return self[safe]
        } else {
            return nil
        }
    }
}
