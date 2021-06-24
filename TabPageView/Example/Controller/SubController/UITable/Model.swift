//
//  Model.swift
//  UITable
//
//  Created by huent18 on 4/1/21.
//

import Foundation

struct Profile {
    init(_ name: String,_ id: String,_ birth: String,_ status: Bool,_ address: String, _ phone: String,_ company: String, _ gender: Bool,_ note : String) {
        self.name = name
        self.id = id
        self.birth = birth
        self.status = status
        self.address = address
        self.phone = phone
        self.company = company
        self.gender = gender
        self.note = note
    }
    var name: String
    var id: String
    var birth: String
    var status: Bool
    var address: String
    var phone: String
    var company: String
    var gender: Bool
    var note: String
}
