//
//  ViewController.swift
//  TabPageView
//
//  Created by TrieuLe on 6/18/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var buttonGo: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TabPage"
        buttonGo.layer.cornerRadius = buttonGo.frame.height/2
        indicator.color = .red
        indicator.style = .large
        indicator.isHidden = true
    }
    
    @IBAction func pressButtonSave(_ sender: Any) {
        indicator.isHidden = false
        indicator.startAnimating()
        let vc = UIStoryboard(name: "TabPage", bundle: nil).instantiateViewController(withIdentifier: RootTabPageViewController.identifier) as? RootTabPageViewController
        if let vc = vc , let navi = navigationController{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
                navi.pushViewController(vc, animated: true)
            }
            
        }
    }
}

