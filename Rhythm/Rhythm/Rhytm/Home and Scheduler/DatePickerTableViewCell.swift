//
//  DatePickerTableViewCell.swift
//  Rhytm
//
//  Created by Ziyuan Li on 4/25/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//
// Set up table view cell of date picker
import UIKit

protocol datePickerDelegate: class {
    func dateChange(indexPath: IndexPath, date: Date)
}

class DatePickerTableViewCell: UITableViewCell {

    var indexPath: IndexPath!
    weak var delegate: datePickerDelegate?
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        datePicker.addTarget(self, action: #selector(dateDidChange), for: .valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updatePicker(date: Date, indexPath: IndexPath) {
        datePicker.setDate(date, animated: true)
        self.indexPath = indexPath
    }

    @objc func dateDidChange(_ sender: Any) {
        let indexPathh = IndexPath(row: indexPath.row - 1, section: indexPath.section)
        self.delegate?.dateChange(indexPath: indexPathh, date: datePicker.date)
    }

}
