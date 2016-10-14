//
//  MenuBar.swift
//  DKMenu
//
//  Created by mac on 16/10/10.
//  Copyright © 2016年 南京麦伦思. All rights reserved.
//

import UIKit

class MenuBar: UITableViewController {

    lazy var menuItems: NSArray = {
        let path = Bundle.main.path(forResource: "MenuItems", ofType: "plist")
        return NSArray(contentsOfFile: path!)!
    }()

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return menuItems.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return max(80, view.bounds.height / CGFloat(menuItems.count))
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as! MenuCell
        let menuItem = menuItems[indexPath.row] as! NSDictionary
        cell.configureForMenuItem(menuItem: menuItem)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let menuItem = menuItems[indexPath.row] as! NSDictionary
        (navigationController!.parent as! DKMenu).menuItem = menuItem
    }
}

class MenuCell: UITableViewCell {
    @IBOutlet weak var menuItemImageView: UIImageView!

    func configureForMenuItem(menuItem: NSDictionary) {
        menuItemImageView.image = UIImage(named: menuItem["image"] as! String)
        backgroundColor = UIColor(colorArray: menuItem["colors"] as! NSArray)
    }
}

extension UIColor {
    convenience init(colorArray array: NSArray) {
        let r = array[0] as! CGFloat
        let g = array[1] as! CGFloat
        let b = array[2] as! CGFloat
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}
