//
//  DayOfTheWeekCollectionViewCell.swift
//  calendar
//
//  Created by 박정아 on 2021/07/09.
//

import UIKit

class DayOfTheWeekCollectionViewCell: UICollectionViewCell {
    let dayOfTheWeekLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDayOfTheWeek()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DayOfTheWeekCollectionViewCell {
    func setDayOfTheWeek() {
        self.addSubview(dayOfTheWeekLabel)
        
        dayOfTheWeekLabel.translatesAutoresizingMaskIntoConstraints = false
        dayOfTheWeekLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        dayOfTheWeekLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        dayOfTheWeekLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
