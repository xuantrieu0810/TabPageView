//
//  DetailViewController.swift
//  UITable
//
//  Created by huent18 on 4/1/21.
//

import UIKit

class DetailViewController: UIViewController {

    
    var profile: Profile?
    
    func getData(profile: Profile) {
        self.profile = profile
    }
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var birth: UILabel!
    
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var company: UILabel!
    
    @IBOutlet weak var note: UILabel!
    @IBOutlet weak var gender: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        name.text = profile?.name
        id.text = profile?.id
        birth.text = profile?.birth
        address.text = profile?.address
        phone.text = profile?.phone
        company.text = profile?.company
        note.text = profile?.note
        gender.text = (profile?.gender) == true ? "nam" : "nữ"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
