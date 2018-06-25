//
//  Models.swift
//  AwesomeDataSource
//
//  Created by Vincent Lin on 2018/6/25.
//  Copyright © 2018 Vincent Lin. All rights reserved.
//

import Foundation

public struct CollectionCellAttribute {
    var titleText: String = ""
    var titleFont: UIFont = UIFont.systemFont(ofSize: 16.0)
    var titleTextColor: UIColor = .darkText
    var titleTextAlignment: NSTextAlignment = .center
    var backgroundColor: UIColor = .white
    
    public init(
        text: String = "",
        font: UIFont = UIFont.systemFont(ofSize: 16.0),
        textColor: UIColor = .darkText,
        textAligment: NSTextAlignment = .center,
        backgroundColor: UIColor = .white
        ) {
        self.titleText = text
        self.titleFont = font
        self.titleTextColor = textColor
        self.titleTextAlignment = textAligment
        self.backgroundColor = backgroundColor
    }
}

public protocol RowModel {
    var cellAttribute: CollectionCellAttribute? { get set }
}

public protocol SectionModel {
    var headerViewAttribute: CollectionCellAttribute? { get set }
    var rowModels: [RowModel] { get set }
    var numberOfRow: Int { get }
    func row(in index: Int) -> RowModel?
}

open class Row: RowModel {
    public var cellAttribute: CollectionCellAttribute?
    public init(attribute: CollectionCellAttribute) {
        self.cellAttribute = attribute
    }
}

open class Section: SectionModel {
    public var headerViewAttribute: CollectionCellAttribute?
    public var rowModels: [RowModel] = []
    public var numberOfRow: Int {
        return rowModels.count
    }
    
    public init(headerAttribute: CollectionCellAttribute? = nil,
                rowModels: [RowModel] = []) {
        self.headerViewAttribute = headerAttribute
        self.rowModels = rowModels
    }
    
    public func row(in index: Int) -> RowModel? {
        return rowModels[safe: index]
    }
}


open class CellAttributeCell: GenericCell<Row> {
    
    var label = CellAttributeLabel()
    
    override func setupViews() {
        super.setupViews()
        label.frame = self.bounds
        addSubview(label)
    }
    
    override public func configure(_ item: Row, at indexPath: IndexPath) {
        super.configure(item, at: indexPath)
        label.cellAttributes = item.cellAttribute
    }
}

public class CellAttributeLabel: UILabel {
    public var cellAttributes: CollectionCellAttribute? = nil {
        didSet {
            guard let attributes = cellAttributes else { return }
            self.backgroundColor = attributes.backgroundColor
            self.text = attributes.titleText
            self.font = attributes.titleFont
            self.textColor = attributes.titleTextColor
            self.textAlignment = attributes.titleTextAlignment
            layoutSubviews()
        }
    }
}

