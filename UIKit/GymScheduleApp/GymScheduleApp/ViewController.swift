//
//  ViewController.swift
//  GymScheduleApp
//
//  Created by Mateusz Krówczyński on 02/07/2025.
//

import UIKit

class ViewController: UIViewController {
    
    private var tableView: UITableView!
    
    private var gymClassesData: [GymClassData] = [
        GymClassData(date: "Friday 21 Feb 2025", classes: [
            GymClassModel(name: "Stretching", day: "Friday", time: "18:00", duration: "55", trainer: TrainerModel(fullName: "Mateusz Krówczyński", photo: "person.circle.fill")),
            GymClassModel(name: "Yoga Flow", day: "Friday", time: "19:00", duration: "60", trainer: TrainerModel(fullName: "Adam Kowalski", photo: "person.circle.fill"), isRegistered: true)
        ]),
        GymClassData(date: "Saturday 22 Feb 2025", classes: [
            GymClassModel(name: "Stretching", day: "Saturday", time: "10:00", duration: "55", trainer: TrainerModel(fullName: "Katarzyna Nowak", photo: "person.circle.fill")),
            GymClassModel(name: "Pilates", day: "Saturday", time: "15:00", duration: "55", trainer: TrainerModel(fullName: "Adam Wójcik", photo: "person.circle.fill"), isRegistered: true)
        ]),
        GymClassData(date: "Sunday 23 Feb 2025", classes: [
            GymClassModel(name: "HIIT", day: "Sunday", time: "11:00", duration: "45", trainer: TrainerModel(fullName: "Piotr Kowal", photo: "person.circle.fill"))
        ]),
        GymClassData(date: "Monday 24 Feb 2025", classes: [
            GymClassModel(name: "Stretching", day: "Monday", time: "09:00", duration: "55", trainer: TrainerModel(fullName: "Mateusz Krówczyński", photo: "person.circle.fill")),
            GymClassModel(name: "Zumba", day: "Monday", time: "17:00", duration: "60", trainer: TrainerModel(fullName: "Anna Lewandowska", photo: "person.circle.fill"))
        ]),
        GymClassData(date: "Tuesday 25 Feb 2025", classes: [
            GymClassModel(name: "Strength Training", day: "Tuesday", time: "18:30", duration: "75", trainer: TrainerModel(fullName: "Adam Wójcik", photo: "person.circle.fill"))
        ]),
        GymClassData(date: "Wednesday 26 Feb 2025", classes: [
            GymClassModel(name: "CrossFit", day: "Wednesday", time: "19:00", duration: "60", trainer: TrainerModel(fullName: "Katarzyna Nowak", photo: "person.circle.fill"))
        ]),
        GymClassData(date: "Thursday 27 Feb 2025", classes: [
            GymClassModel(name: "Cycling", day: "Thursday", time: "20:00", duration: "45", trainer: TrainerModel(fullName: "Adam Kowalski", photo: "person.circle.fill"))
        ])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(GymClassTableViewCell.self, forCellReuseIdentifier: GymClassTableViewCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        view.addSubview(tableView)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return gymClassesData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gymClassesData[section].classes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GymClassTableViewCell.reuseIdentifier, for: indexPath) as? GymClassTableViewCell else {
            return UITableViewCell()
        }
        
        let gymClass = gymClassesData[indexPath.section].classes[indexPath.row]
        cell.configure(with: gymClass, at: indexPath)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return gymClassesData[section].date
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            header.textLabel?.textColor = .darkGray
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            gymClassesData[indexPath.section].classes.remove(at: indexPath.row)

            tableView.deleteRows(at: [indexPath], with: .fade)
            
            if tableView.numberOfSections > indexPath.section && tableView.numberOfRows(inSection: indexPath.section) == 0 {
                gymClassesData.remove(at: indexPath.section)
                tableView.deleteSections(IndexSet(integer: indexPath.section), with: .fade)
            }
        }
    }

}

extension ViewController: GymClassCellDelegate {
    func didTapRegisterButton(for cell: GymClassTableViewCell) {
        guard let indexPath = cell.indexPath else { return }
        
        var gymClass = gymClassesData[indexPath.section].classes[indexPath.row]
        gymClass.isRegistered.toggle()
        gymClassesData[indexPath.section].classes[indexPath.row] = gymClass
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        if gymClass.isRegistered {
            showAlert(title: "Success!", message: "You have registered to \(gymClass.name), see you there!'")
        } else {
            showAlert(title: "Cancelled", message: "You have just cancelled \(gymClass.name) :(")
        }
    }
}

#Preview {
    ViewController()
}

