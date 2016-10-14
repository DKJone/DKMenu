//
//  DetailViewController.swift
//  DKMenu
//
//  Created by mac on 16/10/10.
//  Copyright © 2016年 南京麦伦思. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var hamburgerView: HamburgerView?
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hamburgerViewTapped))
        hamburgerView = HamburgerView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        hamburgerView!.addGestureRecognizer(tapGestureRecognizer)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: hamburgerView!)
    }

    var menuItem: NSDictionary? {
        didSet {
            if let newMenuItem = menuItem {
                view.backgroundColor = UIColor(colorArray: menuItem?["colors"] as! NSArray)
                imageView?.image = UIImage(named: newMenuItem["bigImage"] as! String)
            }
        }
    }

    func hamburgerViewTapped() {
        let navigationController = parent as! UINavigationController
        let containerViewController = navigationController.parent as! DKMenu
        containerViewController.hideOrShowMenu(show: !containerViewController.showingMenu, animated: true)
    }
}

class HamburgerView: UIView {

    let imageView: UIImageView! = UIImageView(image: UIImage(named: "Hamburger"))

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        configure()
    }

    required override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    private func configure() {
        imageView.contentMode = UIViewContentMode.center
        addSubview(imageView)
    }
    func rotate(fraction: CGFloat) {
        let angle = Double(fraction) * M_PI_2
        imageView.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
    }

}
