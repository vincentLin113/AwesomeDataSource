//
//  ViewController.swift
//  CollectionViewPratice
//
//  Created by Vincent Lin on 2018/6/24.
//  Copyright © 2018 Vincent Lin. All rights reserved.
//

import UIKit
import AwesomeDataSource

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


class GenericDataSource<SectionType, ItemType>:
ArrayDataSource<SectionType, ItemType, GenericCell<ItemType>>
where SectionType: SectionModel, ItemType: RowModel {}


class TestVC: UIViewController {
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let _collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        _collectionView.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        _collectionView.alwaysBounceVertical = true
        return _collectionView
    }()
    
    typealias DataType = Section
    typealias ItemType = Row
    fileprivate var dataSource: ArrayDataSource<DataType, ItemType, CellAttributeCell>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let attri = CollectionCellAttribute(text: "Section",backgroundColor: .yellow)
        let rowAttribute = CollectionCellAttribute(text: "row",backgroundColor: .blue)
        let rowAttribute2 = CollectionCellAttribute(text: "Row2", font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(rawValue: 30)), textColor: #colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1), textAligment: .left, backgroundColor: #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1))
        let rowAttribute3 = CollectionCellAttribute(text: "row3",backgroundColor: .red)
        let rowAttribute4 = CollectionCellAttribute.init(text: "Row4", font: UIFont.boldSystemFont(ofSize: 20.0), textColor: .white, textAligment: .right, backgroundColor: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))
        let row1 = Row.init(attribute: rowAttribute)
        let row2 = Row.init(attribute: rowAttribute2)
        let row3 = Row.init(attribute: rowAttribute3)
        let row4 = Row.init(attribute: rowAttribute4)
        let section = Section(headerAttribute: attri, rowModels: [row1, row2, row3, row4])
        self.dataSource = ArrayDataSource<DataType, ItemType, CellAttributeCell>.init(collectionView: collectionView, sectionData: [section])
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
        
        dataSource?.selectedCompletion = {
            indexPath, item, cell in
            print("selected: \(indexPath)")
            print("selectedItem: \(item?.cellAttribute)")
            print("selectedCell: \(cell?.reuseIdentifier)")
        }
        dataSource?.cellSize = {
            indexPath in
            return indexPath.row & 1 == 0
            ? CGSize.init(width: self.view.frame.width, height: 50.0)
            : CGSize.init(width: self.view.frame.width / 2 - 5.0, height: 250.0)
        }
    }
    
}














//
//public protocol CollectionDataProvider {
//    associatedtype T
//
//    func numberOfSection() -> Int
//    func numberOfItems(in section: Int) -> Int
//    func item(at indexPath: IndexPath) -> T?
//
//    func updateItem(at indexPath: IndexPath, value: T)
//}
//
//open class CollectionDataSource<Provider: CollectionDataProvider, Cell: UICollectionViewCell>:
//    NSObject,
//    UICollectionViewDataSource,
//    UICollectionViewDelegate
//where Cell: ConfigurableCell, Provider.T == Cell.T {
//
//    let provider: Provider
//    let collectionView: UICollectionView
//    public var collectionItemSelectionHandler: CollectionItemSelectionHandlerType?
//
//    init(collectionView: UICollectionView, provider: Provider) {
//        self.collectionView = collectionView
//        self.provider = provider
//        super.init()
//        setupCollectionView()
//    }
//
//    func setupCollectionView() {
//        collectionView.delegate = self
//        collectionView.dataSource = self
//    }
//    public func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return provider.numberOfSection()
//    }
//    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return provider.numberOfItems(in: section)
//    }
//
//    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
//            return UICollectionViewCell()
//        }
//
//        if let item = provider.item(at: indexPath) {
//            cell.configure(item, at: indexPath)
//        }
//
//        return cell
//    }
//
//    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionItemSelectionHandler?(indexPath)
//    }
//
//    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        return UICollectionReusableView(frame: .zero)
//    }
//}
//
//public typealias CollectionItemSelectionHandlerType = (IndexPath) -> Void
//
//
//public class ArrayDataProvider<T>: CollectionDataProvider {
//    public func numberOfSection() -> Int {
//        return items.count
//    }
//
//    public func numberOfItems(in section: Int) -> Int {
//        guard section >= 0 && section < items.count else {
//            return 0
//        }
//        return items[section].count
//    }
//
//    public func item(at indexPath: IndexPath) -> T? {
//        guard indexPath.section >= 0 &&
//            indexPath.section < items.count &&
//            indexPath.row >= 0 &&
//            indexPath.row < items[indexPath.section].count else {
//                return nil
//        }
//
//        return items[indexPath.section][indexPath.row]
//    }
//
//    public func updateItem(at indexPath: IndexPath, value: T) {
//        guard indexPath.section >= 0 &&
//            indexPath.section < items.count &&
//            indexPath.row >= 0 &&
//            indexPath.row < items[indexPath.section].count else {
//                return
//        }
//
//        items[indexPath.section][indexPath.row] = value
//    }
//
//
//    var items: [[T]] = []
//
//    init(array: [[T]]) {
//        items = array
//    }
//
//
//}
//
//
//open class CollectionArrayDataSource<T, Cell: UICollectionViewCell>:
//CollectionDataSource<ArrayDataProvider<T>, Cell>
//where Cell: ConfigurableCell, Cell.T == T {
//
//    public convenience init(collectionView: UICollectionView, array: [T]) {
//        self.init(collectionView: collectionView, array: [array])
//    }
//
//    public init(collectionView: UICollectionView, array: [[T]]) {
//        let provider = ArrayDataProvider(array: array)
//        super.init(collectionView: collectionView, provider: provider)
//    }
//
//    public func item(at indexPath: IndexPath) -> T? {
//        return provider.item(at: indexPath)
//    }
//
//    public func updateItem(at indexPath: IndexPath, value: T) {
//        provider.updateItem(at: indexPath, value: value)
//    }
//}
//class model: NSObject {
//
//}
//class TestCell: CollectionCell<model> {
//
//
//}
//class PhotoDataSource: CollectionArrayDataSource<model, TestCell> {
//
//}
//
//protocol DataManager {
//    associatedtype T
//
//    func itemCount() -> Int
//    func itemCount(section: Int) -> Int?
//    func sectionCount() -> Int
//    func itemAtIndexPath(indexPath: IndexPath) -> T
//    func append(newData: [T], toSection: Int)
//
//    func cleanData()
//}
//
//class FlatArrayDataManager<T>: DataManager {
//    func itemCount() -> Int {
//        return data.count
//    }
//
//    func itemCount(section: Int) -> Int? {
//        guard section < 1 else {
//            return nil
//        }
//
//        return itemCount()
//    }
//
//    func sectionCount() -> Int {
//        return 1
//    }
//
//    func itemAtIndexPath(indexPath: IndexPath) -> T {
//        return data[indexPath.item]
//    }
//
//    func append(newData: [T], toSection: Int) {
//        data.append(contentsOf: newData)
//    }
//
//    func cleanData() {
//        data.removeAll()
//    }
//
//    private var data: [T]
//    init(data: [T]) {
//        self.data = data
//    }
//    convenience init() {
//        self.init(data: [T]())
//    }
//
//}
//
//protocol CollectionViewCellPopulator {
//    associatedtype T
//    typealias DataType = T
//    func populate(collectionView: UICollectionView, indexPath: IndexPath, data: T) -> UICollectionViewCell
//}
//
//
//
//
//
//













































