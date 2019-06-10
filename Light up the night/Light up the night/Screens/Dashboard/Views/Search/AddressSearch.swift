//
//  AddressSearch.swift
//  Light up the night
//
//  Created by James Furlong on 9/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import UIKit

class AddressSearch: UIView {
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var resultsStackView: UIStackView!
    var data = AddressSearchResponse()
    
    override func awakeFromNib() {
        searchField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("Error on AddressSearch")
//    }
    
    @objc func textDidChange() {
        let text = searchField.text ?? ""
        if text.count >= 3 {
            GetAddressSearchResults(with: text).dispatch(
                onSuccess: { successResponse in
                    self.data = successResponse
                    self.resultsStackView.subviews.forEach { view in
                        self.resultsStackView.removeArrangedSubview(view)
                    }
                    self.resultsStackView.isHidden = true
                    self.data.prefix(5).forEach { result in
                        self.resultsStackView.addArrangedSubview(
                            AddressResult(
                                address: result.addressPnt
                            )
                        )
                    }
                    self.resultsStackView.isHidden = false
            },
                onError: { errorResponse, error in
                    print("Error on address search result: \(error)")
            })
        } else {
            self.resultsStackView.subviews.forEach { view in
                self.resultsStackView.removeArrangedSubview(view)
            }
            self.resultsStackView.isHidden = true
        }
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if data.count > 5 {
//            data.removeSubrange(4...data.count - 1)
//        }
//
//        let address = data[indexPath.row]
//        guard let cell = resultsTableView.dequeueReusableCell(withIdentifier: "AddressSearch") as? AddressSearchTableViewCell else {
//            return UITableViewCell()
//        }
//
//        cell.updateCell(with: address)
//
//        return cell
//    }
}

