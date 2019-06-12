//
//  AddressSearch.swift
//  Light up the night
//
//  Created by James Furlong on 9/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import UIKit

class AddressSearch: UIView, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var data = AddressSearchResponse()
    
    override func awakeFromNib() {
        searchField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        searchField.becomeFirstResponder()
        tableView.delegate = self
        tableView.dataSource = self
    }
        
    @objc func textDidChange() {
        let text = searchField.text ?? ""
        if text.count >= 3 {
            GetAddressSearchResults(with: text).dispatch(
                onSuccess: { successResponse in
                    self.data = successResponse
                    self.tableView.reloadData()
            },
                onError: { errorResponse, error in
                    print("Error on address search result: \(error)")
            })
        }
        else {
            self.data = [AddressSearchResponseElement(
                streetNo: "",
                gisid: "",
                theGeom: nil,
                strName: "",
                suburb: "",
                addressPnt: "No search results",
                suburbID: "",
                streetID: "",
                easting: "",
                northing: "",
                latitude: "",
                longitude: "",
                addComp: ""
                )]
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if data.count > 5 {
            data.removeSubrange(4...data.count - 1)
        }

        let address = data[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddressSearch") as? AddressSearchTableViewCell else {
            return UITableViewCell()
        }

        cell.updateCell(with: address)

        return cell
    }
}

