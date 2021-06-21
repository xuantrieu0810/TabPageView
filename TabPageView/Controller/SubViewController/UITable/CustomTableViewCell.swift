//
//  CustomTableViewCell.swift
//  UITable
//
//  Created by huent18 on 4/1/21.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var itemName: UILabel!
    
    @IBOutlet weak var itemPhone: UILabel!
    
    @IBOutlet weak var itemAddress: UILabel!
    
    @IBOutlet weak var itemStatus: UIView!
    
    @IBOutlet weak var itemSubview: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initCustomCell(item: Profile) {
//        itemImage.image = UIImage(named: item.image)
        itemName.text = item.name
        itemPhone.text = item.phone
        itemAddress.text = item.address
        itemStatus.backgroundColor = (item.status) ? .green : .red
        itemStatus.layer.cornerRadius = 10
        itemSubview.layer.cornerRadius = 10
        itemImage.layer.cornerRadius = 35
    }
    
}
