//
//  UITableViewCell+Ext.swift
//  MovieApp
//
//  Created by Shrouk Yasser on 25/11/2025.
//

import UIKit

extension UITableView {
    
    /// Generic function for register table view cell
    ///
    /// - Usage:
    ///   - tableview.registerNib(cell: 'your cell'.self)
    func registerNib<Cell: UITableViewCell>(cell: Cell.Type) {
        let nibName = String(describing: Cell.self)
        let bundle = Bundle(for: Cell.self)
        register(UINib(nibName: nibName, bundle: bundle), forCellReuseIdentifier: nibName)
    }
    
    func registerHeaderFooterClass<T: UITableViewHeaderFooterView>(_ type: T.Type) where T: UITableViewHeaderFooterView {
        let nibName = String(describing: T.self)
        
        register(
            T.self,
            forHeaderFooterViewReuseIdentifier: nibName
        )
    }
    
    /// Generic function for dequeue table view cell
    ///
    /// - Usage:
    ///   - let cell = tableview.dequeue() as 'your cell'
    func dequeue<Cell: UITableViewCell>() -> Cell {
        let identifier = String(describing: Cell.self)
        
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier) as? Cell else {
            fatalError("Not found cell")
        }
        
        return cell
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        let identifier = String(describing: T.self)
        
        guard let cell = self.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? T else {
            fatalError("Not found cell")
        }
        
        return cell
    }
}
