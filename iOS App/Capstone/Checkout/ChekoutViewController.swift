//
//  ChekoutViewController.swift
//  Capstone
//
//  Created by Jeton Ajeti on 3/6/19.
//  Copyright © 2019 Gotham Appsters. All rights reserved.
//

import UIKit
import Firebase

var products = [Product]()
class ChekoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var displayNumberOfItems: UILabel!
    
    @IBAction func mainMenuButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        print("Ron's a bastard")
        print(products)
        for product in products {
            print(product.Sku)
            print(product.Items)
            let SKU = product.Sku
            let items = Int(truncating: product.Items) - 1
            print("The new item number is \(items)")
            let NSitems: NSNumber = items as NSNumber
            Firebase_Database.collection("Stores").document("Store One").collection("Store Products").document(SKU ?? "err").setData([ "items":  items], merge: true)
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var totalLabel: UILabel!
    var ProcutsArray = [Product]()
    
    var sku_token_array = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        // Do any additional setup after loading the view.
        displayNumberOfItems.text = "\(products.count)"
        print("THIS IS SPARATAAAAAAA!")
        let sku_tokens = sku_string?.components(separatedBy: " ")
        
        for sku in sku_tokens ?? ["nil"] {
            if sku == "#"  {
                break
            } else {
                sku_token_array.append(sku)
            }
            
        }
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(products)
        products = []
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    var totalPrice:Double = 0
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckoutCustomCell", for: indexPath) as! CheckoutTableViewCell
        
       
        let product = products[indexPath.row]
        cell.priceLabel.text = "$\(product.Price!)"
        cell.itemName.text = product.Name
        //cell.quantityLabel.text = product.Price
        print(product.Price as! Double)
        totalPrice = totalPrice + (product.Price as! Double)
        let thePrice = Double(round(100*totalPrice)/100)
        totalLabel.text = ("$\(thePrice)")
        
        return cell
    }
    
}
