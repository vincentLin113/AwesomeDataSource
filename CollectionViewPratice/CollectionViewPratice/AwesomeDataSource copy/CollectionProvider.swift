//
//  CollectionProvider.swift
//  CollectionViewPratice
//
//  Created by Vincent Lin on 2018/6/24.
//  Copyright © 2018 Vincent Lin. All rights reserved.
//

import Foundation
import UIKit


public protocol CollectionProvider {
    
    associatedtype T
    associatedtype R
    
    func numberOfSection() -> Int
    func numberOfRowInSection(_ section: Int) -> Int
    func itemForIndexPath(_ indexPath: IndexPath) -> R?
    func updateData(in indexPath: IndexPath, value: T)
}

