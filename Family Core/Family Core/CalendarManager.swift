//
//  CalendarManager.swift
//  Family Core
//
//  Created by Vincent Siu on 12/25/25.
//

import Foundation
import UIKit

class calendarManager: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var calendarView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.dataSource = self
        calendarView.delegate = self
        calendarView.backgroundColor = .blue
        
    }
    
    func numDaysInMonth() -> Int {
        let calendar = Calendar.current
        let currDate = Date()
        
        let range = calendar.range(of: .day, in: .month, for: currDate)!
        print("Number of days in month: \(range.count)")
        return range.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return numDaysInMonth()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayCell", for: indexPath) as! DayCell
        cell.dayLabel.text = "\(indexPath.item + 1)"
        print("\(indexPath.item + 1)")
        cell.dayLabel.textAlignment = .center
        cell.dayLabel.textColor = .black
        cell.dayLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        cell.backgroundColor = UIColor(white: 0.95, alpha: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7
        return CGSize(width: width, height: width)
    }
}
