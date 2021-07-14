//
//  CalendarViewController.swift
//  Calendar
//
//  Created by 박정아 on 2021/07/09.
//

import UIKit

private let reuseIdentifier = "Cell"

class CalendarViewController: UIViewController {
    private let YearMonthLabel: UILabel = UILabel()
    private let dayOfTheWeekCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        return collectionView
    }()
    private let calendarCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        return collectionView
    }()
    
    private let currentDate = Date()
    private let dateFormatter = DateFormatter()
    private let dayOfTheWeek: [String] = ["S", "M", "T", "W", "T", "F", "S"]
    
    private let calendar = Calendar.current
    private var components = DateComponents()
    private var days: [String] = []
    private var startDayOfTheWeek = 0
    private var endDay = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        dateFormatter.dateFormat = "yyyy년 MM월"
        components.year = calendar.component(.year, from: currentDate)
        components.month = calendar.component(.month, from: currentDate)
        components.day = 1
        setDayInCalendar()
        setLayout()
    }
}

extension CalendarViewController {
    func setLayout() {
        view.addSubview(YearMonthLabel)
        view.addSubview(dayOfTheWeekCollectionView)
        view.addSubview(calendarCollectionView)
        
        YearMonthLabel.translatesAutoresizingMaskIntoConstraints = false
        dayOfTheWeekCollectionView.translatesAutoresizingMaskIntoConstraints = false
        calendarCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        // titleView
        YearMonthLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        YearMonthLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        YearMonthLabel.trailingAnchor.constraint(equalTo:YearMonthLabel.safeAreaLayoutGuide.trailingAnchor, constant: 16).isActive =  true
        YearMonthLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        
        YearMonthLabel.text = dateFormatter.string(from: currentDate)
        YearMonthLabel.font = .boldSystemFont(ofSize: 22)
        
        // dayOfTheWeekTableView
        dayOfTheWeekCollectionView.dataSource = self
        dayOfTheWeekCollectionView.delegate = self
        
        dayOfTheWeekCollectionView.topAnchor.constraint(equalTo: YearMonthLabel.bottomAnchor).isActive = true
        dayOfTheWeekCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        dayOfTheWeekCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        dayOfTheWeekCollectionView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        dayOfTheWeekCollectionView.backgroundColor = .systemBackground
        dayOfTheWeekCollectionView.register(DayOfTheWeekCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // calendarCollectionView
        calendarCollectionView.dataSource = self
        calendarCollectionView.delegate = self

        calendarCollectionView.topAnchor.constraint(equalTo: dayOfTheWeekCollectionView.bottomAnchor).isActive = true
        calendarCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        calendarCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        calendarCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true

        calendarCollectionView.backgroundColor = .systemBackground
        calendarCollectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
}

extension CalendarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == dayOfTheWeekCollectionView {
            return 7
        } else if collectionView == calendarCollectionView {
            return days.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == dayOfTheWeekCollectionView {
            let cell = dayOfTheWeekCollectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DayOfTheWeekCollectionViewCell
            cell.dayOfTheWeekLabel.text = dayOfTheWeek[indexPath.row]
            return cell
        } else if collectionView == calendarCollectionView {
            let cell = calendarCollectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CalendarCollectionViewCell
            cell.layer.borderWidth = 0.3
            cell.layer.borderColor = UIColor.label.cgColor
            cell.dayLabel.text = days[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
}

extension CalendarViewController: UICollectionViewDelegate {

}

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == dayOfTheWeekCollectionView {
            let width = view.frame.width / 7
            return CGSize(width: width, height: 30)
        } else if collectionView == calendarCollectionView {
            let width = view.frame.width / 7
            return CGSize(width: width, height: width + width / 2)
        }
        return CGSize(width: 0, height: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension CalendarViewController {
    func setDayInCalendar() {
        let firstDay = calendar.date(from: components)!
        let firstDayOfTheWeek = calendar.component(.weekday, from: firstDay)
        
        endDay = calendar.range(of: .day, in: .month, for: firstDay)!.count
        startDayOfTheWeek = 2-firstDayOfTheWeek
        
//        self.YearMonthLabel.text = dateFormatter.string(from: firstDay)
        
        days.removeAll()
        for day in startDayOfTheWeek...endDay {
            if day < 1 {
                days.append("")
            } else {
                days.append("\(day)")
            }
        }
    }
}
