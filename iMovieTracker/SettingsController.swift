//
//  SettingsController.swift
//
//
//  Created by Niels Evenblij on 03/04/2019.
//

import UIKit

class SettingsController: UITableViewController {
    
    var settings = [Setting]()
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createSettings()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Setting")
        cell.textLabel?.text = settings[indexPath.row].setting
        let switchView = UISwitch(frame: .zero)
        switchView.setOn(settings[indexPath.row].value, animated: true)
        switchView.tag = indexPath.row
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        cell.accessoryView = switchView
        
        return cell;
    }
    
    @objc func switchChanged(_ sender: UISwitch){
        settings[sender.tag].value = sender.isOn
        defaults.set(sender.isOn, forKey: settings[sender.tag].setting)
    }
    
    func createSettings() {
        //create settings
        
        
        //if setting exists in userdefaults.standard
        if defaults.string(forKey: "hideMoviePoster") != nil {
            settings.append(Setting(setting: "hideMoviePoster", title: "Hide movie poster", value: defaults.bool(forKey: "hideMoviePoster")))
        }
        else {
            defaults.set(false, forKey: "hideMoviePoster")
            settings.append(Setting(setting: "hideMoviePoster", title: "Hide movie poster", value: false))
        }
    }
}
