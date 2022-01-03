//
//  CalendarCollectionViewCell.swift
//  Calendar
//
//  Created by 박정아 on 2022/01/02.
//

import UIKit

final class CalendarCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CalendarCollectionViewCell"
    
    private lazy var dayLabel = UILabel()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    override func prepareForReuse() {
        self.dayLabel.text = nil
    }
    
    func update(day: String) {
        self.dayLabel.text = day
    }
    
    private func configure() {
        self.addSubview(self.dayLabel)
        self.dayLabel.font = .boldSystemFont(ofSize: 12)
        self.dayLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.dayLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.dayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
}
