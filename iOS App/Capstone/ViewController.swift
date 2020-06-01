//
//  ViewController.swift
//  Capstone
//
//  Created by Jeton Ajeti on 10/16/18.
//  Copyright © 2018 Gotham Appsters. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseFirestore

let Firebase_Database = Firestore.firestore()
class ViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var textBox: UITextField!
    override func viewDidLoad() {
        
        
        var address: String?
        
        address = textBox.text
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        GIDSignIn.sharedInstance().uiDelegate = self
        silenceTimestampWarning()
        Authentication()
    }
    
    func Authentication() {
        if let user = Auth.auth().currentUser {
            print("The USER is SIGNED IN!")
            print("This is the USER ID: \(user.uid)")
            writeToFirestore(userID: user.uid)
        } else {
            print("The USER is **NOT** SIGNED IN!")
        }
    }
    let Firebase_Database = Firestore.firestore()
    func writeToFirestore(userID: String) {
        let databaseManager = Firebase_Database.collection("Stores").document("Store One")
        let databaseCustomer = databaseManager.collection("Customers").document(userID)
        let databaseCart = databaseCustomer.collection("Cart")
        databaseCart.document("Book").setData(["created" : true], merge: true)
        databaseCustomer.setData([
            "name": "Jeton"
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        databaseManager.setData([
            "manager": "John",
            "location": "Manhattan"
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func silenceTimestampWarning() {
        let settings = Firebase_Database.settings
        settings.areTimestampsInSnapshotsEnabled = true
        Firebase_Database.settings = settings
    }
}

