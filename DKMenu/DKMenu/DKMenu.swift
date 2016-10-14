//
//  DKMenu.swift
//  DKMenu
//
//  Created by mac on 16/10/10.
//  Copyright © 2016年 南京麦伦思. All rights reserved.
//

import UIKit

class DKMenu: UIViewController {
    var detailViewController: DetailViewController?

    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var menuBar: UIView!
    var showingMenu = false

    static let shared = UIStoryboard(name: "DKMenu", bundle: nil).instantiateViewController(withIdentifier: "DKMenu")

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        hideOrShowMenu(show: showingMenu, animated: false)
        menuBar.layer.anchorPoint = CGPoint(x: 1.0, y: 0.5)
    }

    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailViewSegue" {
            let navigationController = segue.destination as! UINavigationController
            detailViewController = navigationController.topViewController as? DetailViewController
        }

    }

    var menuItem: NSDictionary? {
        didSet {
            if let detailViewController = detailViewController {
                detailViewController.menuItem = menuItem
                hideOrShowMenu(show: false, animated: true)
            }
        }
    }

    func hideOrShowMenu(show: Bool, animated: Bool) {
        let menuOffset = menuBar.bounds.width
        scrollView.setContentOffset(show ? CGPoint() : CGPoint(x: menuOffset, y: 0), animated: animated)
    }

}

// MARK: - UIScrollViewDelegate
extension DKMenu: UIScrollViewDelegate {
    // fix 存在回弹和收不回去的问题
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.isPagingEnabled = scrollView.contentOffset.x < (scrollView.contentSize.width - scrollView.frame.width)
        let multiplier = 1.0 / menuBar.bounds.width
        let offset = scrollView.contentOffset.x * multiplier
        let fraction = 1.0 - offset
        menuBar.layer.transform = transformForFraction(fraction: fraction)
        menuBar.alpha = fraction
        if let detailViewController = self.detailViewController {
            if let rotatingView = detailViewController.hamburgerView {
                rotatingView.rotate(fraction: fraction)
            }
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let menuOffset = menuBar.bounds.width
        showingMenu = !CGPoint(x: menuOffset, y: 0).equalTo(scrollView.contentOffset)
    }

    func transformForFraction(fraction: CGFloat) -> CATransform3D {
        var identity = CATransform3DIdentity
        identity.m34 = -1.0 / 1000.0;
        let angle = Double(1.0 - fraction) * -M_PI_2
        let xOffset = menuBar.bounds.width * 0.5
        let rotateTransform = CATransform3DRotate(identity, CGFloat(angle), 0.0, 1.0, 0.0)
        let translateTransform = CATransform3DMakeTranslation(xOffset, 0.0, 0.0)
        return CATransform3DConcat(rotateTransform, translateTransform)
    }
}
