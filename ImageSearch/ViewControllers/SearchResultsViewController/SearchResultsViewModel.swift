//
//  SearchResultsViewModel.swift
//  Candyspace
//
//  Created by gaetano cerniglia on 16/03/2020.
//  Copyright © 2020 Gaetano Cerniglia. All rights reserved.
//

import UIKit

class SearchResultsViewModel {
    
    let cellModels: [ImageTableViewCellViewModel]
    
    var tableView: UITableView? {
        didSet { setupTableView() }
    }
    
    private var datasource: UITableViewDiffableDataSource<Int, ImageTableViewCellViewModel>?
    
    /// The Init use the Dependency Injection to receive the PixabayImage array Model
    init(images: [PixabayImage]) {
        self.cellModels = images.map { ImageTableViewCellViewModel(pixabayImage: $0) }
    }
    
    /// Setup the Table View with a Diffable Data Source and populate the table
    func setupTableView() {
        if let _tableView = tableView {
            self.datasource = UITableViewDiffableDataSource(tableView: _tableView, cellProvider: { (tableView, indexPath, cellModel) -> UITableViewCell? in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ImageTableViewCell
                cell.configure(with: cellModel)
                return cell
            })
            /// append items to the snapshot
            var snapshot = NSDiffableDataSourceSnapshot<Int, ImageTableViewCellViewModel>()
            snapshot.appendSections([0])
            snapshot.appendItems(cellModels, toSection: 0)
            datasource?.apply(snapshot, animatingDifferences: false)
        } else {
            datasource = nil
        }
    }
    
    
}
