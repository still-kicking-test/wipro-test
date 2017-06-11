//
//  ForecastViewController.swift
//  WiproTask
//
//  Created by Jonathan Saville on 11/06/2017.
//  Copyright © Jonathan Saville. All rights reserved.
//

import Foundation
import UIKit

class ForecastViewConstants {
    
    static let cellId = "ForecastViewCell"
    static let cellNibName = "ForecastViewCell"
    static let tableAccessibilityId = "ForecastView_Table"
}

class ForecastViewController: UIViewController {
    
    var presenter: ForecastPresenterInput!
    
    fileprivate var tableView = UITableView()
    fileprivate var rowHeight = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
       tableView.delegate   = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: ForecastViewConstants.cellNibName, bundle: nil), forCellReuseIdentifier: ForecastViewConstants.cellId)
        tableView.accessibilityIdentifier = ForecastViewConstants.tableAccessibilityId
        view.addSubview(tableView)
        
        let dummyCell = Bundle.main.loadNibNamed(ForecastViewConstants.cellNibName, owner: nil, options: nil)![0] as! UITableViewCell
        rowHeight = Int(dummyCell.contentView.frame.size.height);
        
        addStaticConstraints()
        
        presenter.onViewIsReady()
    }
    
    func addStaticConstraints() {
        
        let staticConstraints = NSMutableArray()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set the tableView constraints...
        staticConstraints.add(NSLayoutConstraint(item: tableView, attribute: .left,  relatedBy: NSLayoutRelation.equal, toItem: view, attribute: .left,  multiplier: 1, constant: 0))
        staticConstraints.add(NSLayoutConstraint(item: tableView, attribute: .right, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: .right, multiplier: 1, constant: 0))
        staticConstraints.add(NSLayoutConstraint(item: tableView, attribute: .top,   relatedBy: NSLayoutRelation.equal, toItem: view, attribute: .top,   multiplier: 1, constant: 0))
        staticConstraints.add(NSLayoutConstraint(item: tableView, attribute: .bottom,relatedBy: NSLayoutRelation.equal, toItem: view, attribute: .bottom,multiplier: 1, constant: 0))
        
        view.addConstraints(staticConstraints as! [NSLayoutConstraint])
        
        view.updateConstraints()
    }
}

extension ForecastViewController : ForecastViewInput {
    
    func onDataDidChange(locationName: String) {
    
        self.navigationItem.title = locationName
        tableView.reloadData()
    }
}

extension ForecastViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(rowHeight)
    }
}

extension ForecastViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.forecastCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastViewConstants.cellId, for: indexPath) as! ForecastViewCell
        
        let forecast = presenter.forecastAtIndex(indexPath.row)
        
        if let forecast = forecast {
            cell.temperature.text = forecast.temperature
            cell.summary.text = forecast.summary
            cell.pressure.text = forecast.pressure
            cell.wind.text = forecast.wind
            cell.date.text = forecast.date
            cell.icon.image = UIImage(named:forecast.icon)
        }
        else {
            cell.temperature.text = ""
            cell.summary.text = ""
            cell.pressure.text = ""
            cell.wind.text = ""
            cell.date.text = ""
            cell.icon.image = nil
        }
        
        return cell
    }
}
