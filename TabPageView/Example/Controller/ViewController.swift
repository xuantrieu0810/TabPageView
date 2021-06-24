import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var buttonGo: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        buttonGo.layer.cornerRadius = buttonGo.frame.height/2
        indicator.color = .red
        indicator.isHidden = true
    }
    
    @IBAction func pressButtonSave(_ sender: Any) {
        indicator.isHidden = false
        indicator.startAnimating()
        if  let navi = navigationController{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
                
                navi.pushViewController(ExampleViewController(nibName: nil, bundle: nil), animated: true)
            }
        }
    }
}

