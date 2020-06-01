//
//  ProductStructure.swift
//  Capstone
//
//  Created by Jeton Ajeti on 3/29/19.
//  Copyright © 2019 Gotham Appsters. All rights reserved.
//

import Foundation

struct Product{
    
    let Name: String!
    let Price: NSNumber!
    let ImgURL: String!
    let Category: String!
    let Items: NSNumber!
    let Sku: String!
    
    init(name: String, price: NSNumber, imageURL: String, quantity: String, itmes: NSNumber, sku: String) {
        self.Name = name
        self.Price = price
        self.ImgURL = imageURL
        self.Category = quantity
        self.Items = itmes
        self.Sku = sku
    }
    
    init(dictionary: [String: Any], SKU: String) {
        self.Name = (dictionary["productName"]! as? String ?? "")
        self.Price = (dictionary["price"]! as? NSNumber)
        self.ImgURL = (dictionary["imageURL"]! as? String ?? "")
        self.Category = (dictionary["category"]! as? String ?? "")
        self.Items = (dictionary["items"]! as? NSNumber)
        self.Sku = SKU
    }
    
    
}
