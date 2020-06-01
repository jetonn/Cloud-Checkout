//
//  NFC_ScanViewController.swift
//  Capstone
//
//  Created by Jeton Ajeti on 12/4/18.
//  Copyright © 2018 Gotham Appsters. All rights reserved.
//

import UIKit
import CoreNFC
import Firebase
import FirebaseFirestore


var sku_string: String?
var sku_array = [String]()
let Group = DispatchGroup()
class NFC_ScanViewController: UIViewController, NFCNDEFReaderSessionDelegate {
    
    
    @IBAction func categoriesButton(_ sender: UIButton) {
        print(sender.currentTitle ?? "")
        let category: String = sender.currentTitle ?? ""
        
        
        Group.enter()
        let docRef = Firebase_Database.collection("Stores").document("Store One").collection("Store Products")
        docRef.whereField("category", isEqualTo: "\(category)")
                .getDocuments() { (querySnapshot, err) in
                    
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        var i = 0
                        for document in querySnapshot!.documents {
                            i = i + 1
                            print(document.data())
                            print(document.documentID)
                            let product = Product(dictionary: document.data(), SKU: document.documentID)//Product(dictionary: document.data())
                            print(product)
                            categoryProducts.append(product)
                            
                            if i == querySnapshot!.documents.count {
                                print("Now is equal \(i)")
                                Group.leave()
                            }
                            print(querySnapshot!.documents.count)
                            
                        }
                        
                    }
            }
        Group.notify(queue: .main) {
            print("Finished all requests.")
            self.performSegue(withIdentifier: "productDisplay", sender: self)
            
        }
        
    }
    

    var nfcSession: NFCNDEFReaderSession?
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        sku_array = []
        sku_token_array = []
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
    
    @IBAction func ScanButton(_ sender: UIButton) {
        nfcSession = NFCNDEFReaderSession.init(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        nfcSession?.begin()
    }
    
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("The session was invalidated: \(error.localizedDescription)")
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        // Parse the card's information
        print("READER_SESSION")
        var result = ""
        for payload in messages[0].records {
            result += String.init(data: payload.payload.advanced(by: 3), encoding: .utf8)! // 1
        }
        DispatchQueue.main.sync {
            self.SetNFCData(SKU: result)
        }
        DispatchQueue.main.async {
            
        }
    }
    
    var sku_token_array = [String]()
    func SetNFCData(SKU: String){
        sku_string = SKU
        let sku_tokens = sku_string?.components(separatedBy: " ")
        for sku in sku_tokens ?? ["nil"] {
            if sku == "#"  {
                break
            } else {
                sku_token_array.append(sku)
            }
        }
        self.FetchProductData(tokens: self.sku_token_array)
    }
    
    func FetchProductData(tokens: [String]) { //Fetch product data from the database.
        let myGroup = DispatchGroup()
        for token in tokens { //Tokens store SKU numbers of the products a customer has in the cart.
            myGroup.enter()
            let docRef = Firebase_Database.collection("Stores").document("Store One").collection("Store Products").document(token) // Fetch the product info for a specific product.
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data()
                    let product = Product(dictionary: dataDescription!, SKU: document.documentID)
                    products.append(product) //Append product data to an array.
                    myGroup.leave()
                } else {
                    print("Document does not exist")
                }
            }
        }
        myGroup.notify(queue: .main) {
            self.performSegue(withIdentifier: "linkToCheckout", sender: self) // Once all the data has been retrieved form the FB, segue to the following VC.
        }
    }
}
