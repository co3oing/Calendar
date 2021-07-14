//
//  CalendarCollectionViewCell.swift
//  Calendar
//
//  Created by 박정아 on 2021/07/09.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    let dayLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDay()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CalendarCollectionViewCell {
    func setDay() {
        self.addSubview(dayLabel)
        
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dayLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        dayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}
