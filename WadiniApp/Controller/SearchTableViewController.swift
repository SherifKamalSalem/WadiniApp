//
//  SearchTableViewController.swift
//  WadiniApp
//
//  Created by Sherif Kamal on 11/24/18.
//  Copyright © 2018 Sherif Kamal. All rights reserved.
//

import UIKit
import MapKit

class SearchTableViewController: UIViewController {

    @IBOutlet weak var confirmBtn: RoundedShadowButton!
    @IBOutlet weak var pickupSearchBar: UISearchBar!
    @IBOutlet weak var dropOffSearchBar: UISearchBar!
    @IBOutlet weak var searchResultsTableView: UITableView!
    
    var regionRadius: CLLocationDistance = 1000
    
    let pickupCompleter = MKLocalSearchCompleter()
    let dropOffCompleter = MKLocalSearchCompleter()
    
    var pickupSearchResults = [MKLocalSearchCompletion]()
    var dropOffSearchResults = [MKLocalSearchCompletion]()
    
    var pickupMapItem: MKMapItem?
    var dropoffMapItem: MKMapItem?
    
    let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        searchResultsTableView.delegate = self
        searchResultsTableView.dataSource = self
        pickupCompleter.delegate = self
        dropOffCompleter.delegate = self
            
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if dropOffSearchBar.text != "" {
            confirmBtn.isHidden = false
        } else if dropOffSearchBar.text == "" {
            confirmBtn.isHidden = true
        }
        
        UpdateService.instance.lookUpCurrentLocation { (currentPlacemark) in
            guard let currentPlacemark = currentPlacemark else { return }
            self.pickupSearchBar.text = currentPlacemark.name!
        }
    }
    //MARK: - IBActions
    
    @IBAction func confirmDropoffBtnPressed(_ sender: Any) {
        
        guard let dropoffMapItem = dropoffMapItem else { return }
        //guard let pickupMapItem = pickupMapItem else { return }
        self.homeVC.matchingDropoff = dropoffMapItem
        self.homeVC.matchingPickup = pickupMapItem
        let mapItemsDictionary = ["pickup" : pickupMapItem, "dropoff" : dropoffMapItem]
        NotificationCenter.default.post(name: .didReceiveData, object: nil, userInfo: mapItemsDictionary)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        let mapItemsDictionary = ["pickup" : pickupMapItem, "dropoff" : dropoffMapItem]
        NotificationCenter.default.post(name: .didReceiveData, object: nil, userInfo: mapItemsDictionary)
        dismiss(animated: true, completion: nil)
    }
}

extension SearchTableViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
        if searchBar == dropOffSearchBar {
            pickupSearchResults.removeAll()
            searchResultsTableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar == pickupSearchBar && searchBar.text != "" {
            pickupCompleter.queryFragment = searchText
        } else if searchBar == dropOffSearchBar && searchBar.text != "" {
            dropOffCompleter.queryFragment = searchText
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if searchBar == pickupSearchBar {
            pickupSearchResults.removeAll()
            searchResultsTableView.reloadData()
        } else if searchBar == dropOffSearchBar {
            dropOffSearchResults.removeAll()
            searchResultsTableView.reloadData()
        }
        
    }
}

extension SearchTableViewController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        if completer == pickupCompleter && completer.results.count > 0{
            pickupSearchResults.removeAll()
            pickupSearchResults = completer.results
            searchResultsTableView.reloadData()
        } else if completer == dropOffCompleter && completer.results.count > 0 {
            dropOffSearchResults.removeAll()
            dropOffSearchResults = completer.results
            searchResultsTableView.reloadData()
        }
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // handle error
        print("error: \(error)")
    }
}

extension SearchTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if pickupSearchResults.count > 0 {
            return pickupSearchResults.count
        } else if dropOffSearchResults.count > 0 {
            return dropOffSearchResults.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if pickupSearchResults.count > 0 {
            let searchResult = pickupSearchResults[indexPath.row]
            let cell = searchResultsTableView.dequeueReusableCell(withIdentifier: "searchTableCell", for: indexPath) as! SearchTableCell
            cell.configureCell(searchResult: searchResult)
            return cell
        } else if dropOffSearchResults.count > 0 {
            let searchResult = dropOffSearchResults[indexPath.row]
            let cell = searchResultsTableView.dequeueReusableCell(withIdentifier: "searchTableCell", for: indexPath) as! SearchTableCell
            cell.configureCell(searchResult: searchResult)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if pickupSearchResults.count > 0 {
            let completion = pickupSearchResults[indexPath.row]
        
            let searchRequest = MKLocalSearch.Request(completion: completion)
            let search = MKLocalSearch(request: searchRequest)
            search.start { (response, error) in
                self.pickupMapItem = response?.mapItems.first
                self.pickupSearchBar.text = response?.mapItems.first?.name
                self.pickupSearchResults.removeAll()
                self.searchResultsTableView.reloadData()
                let coordinate = response?.mapItems[0].placemark.title
                print(String(describing: coordinate))
            }
            
        } else if dropOffSearchResults.count > 0 {
            self.searchResultsTableView.reloadData()
            let completion = dropOffSearchResults[indexPath.row]
            
            let searchRequest = MKLocalSearch.Request(completion: completion)
            let search = MKLocalSearch(request: searchRequest)
            search.start { (response, error) in
                self.dropoffMapItem = response?.mapItems.first
                self.dropOffSearchBar.text = response?.mapItems.first?.name
                self.confirmBtn.isHidden = false
            }
        }
    }
}
