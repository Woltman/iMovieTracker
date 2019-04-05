//
//  SettingsController.swift
//
//
//  Created by Niels Evenblij on 03/04/2019.
//

import UIKit

class SettingsController: UITableViewController {
    
    var settings = [Setting]()
    var defaultStorage = DefaultStorage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        
        createSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Settings"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Setting")
        cell.textLabel?.text = settings[indexPath.row].title
        let switchView = UISwitch(frame: .zero)
        switchView.setOn(settings[indexPath.row].value, animated: true)
        switchView.tag = indexPath.row
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        cell.accessoryView = switchView
        
        return cell;
    }
    
    @objc func switchChanged(_ sender: UISwitch){
        settings[sender.tag].value = sender.isOn
        defaultStorage.setSetting(key: settings[sender.tag].key, value: sender.isOn)
    }
    
    func createSettings() {
        
        let hideMoviePoster = Setting(key: "hideMoviePoster", title: "Hide Movie Poster", value: false)
        let hideSubtitle = Setting(key: "hideSubtitle", title: "Hide Subtitle", value: false)
        
        settings.append(hideMoviePoster)
        settings.append(hideSubtitle)
        
        loadSettings()
    }
    
    func loadSettings() {
        for setting in settings {
            setting.value = defaultStorage.getSetting(key: setting.key)
        }
    }
}
