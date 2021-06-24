//
//  ViewController.swift
//  UITable
//
//  Created by huent18 on 4/1/21.
//

import UIKit

class ThirdViewController: UIViewController {

    static let identifier = "ThirdViewController"
    @IBOutlet weak var btnEdit: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var pfSelected: Profile?
    var listItem: [Profile] =
        [
            Profile("Hoàng Kim Tiến" , "TienHK" , "01/04/1994", true , "Ho Chi Minh city", "0987654321", "FSoft", true , "012345678"),

            Profile("Nguyễn Thanh Sang" , "SangNT" , "01/04/1994", false, "Ho Chi Minh city", "0123456789", "FSoft", true , "098765432"),

            Profile("Đặng Xuân Hùng" , "HungDX" , "29/04/1995", true , "Ho Chi Minh city", "0987789987", "FSoft", true , "098798798"),

            Profile("Nguyễn Đức Anh" , "AnhND" , "10/04/1994", true , "Ho Chi Minh city", "0123123123", "FSoft", true , "012312312"),

            Profile("Lã Thị Phương Hân" , "HanLTP" , "12/04/1999", false, "Ho Chi Minh city", "0456456456", "FSoft", false, "045645645"),

            Profile("Nguyễn Tiến Phú" , "PhuNT" , "29/04/1998", true , "Ho Chi Minh city", "0981784459", "FSoft", true , "087609539"),

            Profile("Lê Minh Vũ" , "VuLM" , "29/04/1999", true , "Ho Chi Minh city", "0908638292", "FSoft", false, "012345612"),

            Profile("Huỳnh Thị Yến Nhi" , "NhiHTY" , "01/04/1998", false, "Ho Chi Minh city", "0987654321", "FSoft", false, "076543210"),

            Profile("Bùi Minh Tuấn" , "TuanBM" , "05/03/1997", false, "Ho Chi Minh city", "0123456789", "FSoft", true , "012345678"),

            Profile("Đặng Quang Khải" , "KhaiDQ" , "06/02/1999", true , "Ho Chi Minh city", "0987789987", "FSoft", true , "098798798"),

            Profile("Lê Xuân Triều" , "TrieuTX" , "19/05/1998", true , "Ho Chi Minh city", "0123123123", "FSoft", true , "045645645"),

            Profile("Nguyễn Hữu Hùng" , "HungNH" , "21/01/1999", false, "Ho Chi Minh city", "0456456456", "FSoft", true , "012345612"),

            Profile("Nguyễn Thanh Phúc" , "PhucNT" , "01/09/1998", true , "Ho Chi Minh city", "0123456789", "FSoft", true , "012345678"),

            Profile("Nguyễn Văn Nhật" , "NhatNV" , "29/08/1998", false, "Ho Chi Minh city", "0908638292", "FSoft", true , "098765432"),

            Profile("Phan Quang Công" , "CongPQ" , "22/07/1999", false, "Ho Chi Minh city", "0987654321", "FSoft", true , "098798798"),

            Profile("Tô Vũ Dương" , "DuongTV" , "24/05/1999", true , "Ho Chi Minh city", "0123456789", "FSoft", true , "012312312"),

            Profile("Trần Hoàng Tiến" , "TienTH" , "21/04/1999", true , "Ho Chi Minh city", "0987789987", "FSoft", true , "045645645"),

            Profile("Trần Thanh Nhàn" , "NhanTT" , "03/02/1998", true , "Ho Chi Minh city", "0123123123", "FSoft", true , "088888888"),

            Profile("Võ Anh Trưởng" , "TruongVA" , "09/09/1998", false, "Ho Chi Minh city", "0456456456", "FSoft", true , "099999999")
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
    }

    func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
    }

    @IBAction func edit(_ sender: Any) {
        if tableView.isEditing{
            tableView.isEditing = false
            btnEdit.title = "Edit"
        }
        else{
            tableView.isEditing = true
            btnEdit.title = "Done"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "goDetail"
            {
                 let controller = segue.destination as!  DetailViewController
                controller.getData(profile: pfSelected!)
            }
    }
} // End class

extension ThirdViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        cell.initCustomCell(item : listItem[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        pfSelected = listItem[indexPath.row]
        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
//        navigationController?.pushViewController(vc, animated: true)
        
        performSegue(withIdentifier: "goDetail", sender: self)
        
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        listItem.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    
}

