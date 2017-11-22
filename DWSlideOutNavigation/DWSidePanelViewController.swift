//
//  DWSidePanelViewController.swift
//  DWSlideOutNavigation
//
//  Created by Dwyane on 2017/11/20.
//  Copyright © 2017年 DWade. All rights reserved.
//

import UIKit

class DWSidePanelViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var delegate: DWSidePanelViewControllerDelegate?
    
    var stars: Array<DWStar>!
    
    enum CellIdentifiers {
        static let AnimalCell = "DWStarCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.reloadData()
    }

}

// MARK: Table View Data Source

extension DWSidePanelViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stars.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.AnimalCell, for: indexPath) as! DWStarCell
        cell.configureForAnimal(stars[indexPath.row])
        return cell
    }
}

// Mark: Table View Delegate

extension DWSidePanelViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectAnimal(stars[indexPath.row])
    }
}
