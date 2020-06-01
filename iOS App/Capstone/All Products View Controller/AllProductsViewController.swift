//
//  AllProductsViewController.swift
//  Capstone
//
//  Created by Jeton Ajeti on 4/17/19.
//  Copyright © 2019 Gotham Appsters. All rights reserved.
//

import UIKit


var categoryProducts = [Product]()
class AllProductsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    

    @IBAction func closeBTN(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var VCTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        VCTitle.text = categoryProducts[0].Category
        print("This is ALLProductsVC")
        print("This is the array of category products: \(categoryProducts)" )
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        categoryProducts = []
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TheCell", for: indexPath) as! AllProductsTableViewCell
        print("This is table")
        cell.productName.text = categoryProducts[indexPath.row].Name
        let thePrice = Double(round(100*categoryProducts[indexPath.row].Price.doubleValue)/100)
        cell.price.text = "$\(String(thePrice))"
        cell.Description.text = "Only \(categoryProducts[indexPath.row].Items ?? 0) items left."
        let url = URL(string: "\(categoryProducts[indexPath.row].ImgURL!)")
        let data = try? Data(contentsOf: url!)
        
        if let imageData = data {
            let image = UIImage(data: imageData)
            cell.imageViewProduct.image = image
        }
        return cell
    }

}
