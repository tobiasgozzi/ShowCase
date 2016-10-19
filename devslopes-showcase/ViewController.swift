//
//  ViewController.swift
//  devslopes-showcase
//
//  Created by Tobias Gozzi on 06/10/2016.
//  Copyright © 2016 Tobias Gozzi. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) as? String != nil {
            performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
        }
    }
    

    @IBAction func fbButtonPressed(sender: AnyObject) {
        let facebookManager = FBSDKLoginManager()
        
        facebookManager.logInWithReadPermissions(["email"], fromViewController: nil) { (rest: FBSDKLoginManagerLoginResult!, err: NSError!) in
            if err != nil {
                print("facebook error \(err)")
                
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                
//                DataService.ds.REF_BASE
                let credential = FIRFacebookAuthProvider.credentialWithAccessToken(accessToken)
                FIRAuth.auth()?.signInWithCredential(credential, completion: { (userData, err) in
                    
                    if err != nil {
                        print("login failed. \(err)")
                    } else {
                        print("logged in \(userData?.uid)")

                        if let userProvider = userData?.providerData[0].providerID {
                            DataService.ds.createUser(userData!.uid, provider: userProvider)
                        }
                        
                        NSUserDefaults.standardUserDefaults().setValue(userData?.uid, forKey: KEY_UID)
                        self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                    }
                    
                })
                
                
            }
        }
        
    }
    
    @IBAction func emailLoginBtnPressed(sender: UIButton!) {
        if let email = emailField.text where email != "", let password = passwordField.text where password != "" {
            
            let credential = FIREmailPasswordAuthProvider.credentialWithEmail(email, password: password)
            FIRAuth.auth()?.signInWithCredential(credential, completion: { (userData: FIRUser?, error: NSError?) in
                if error != nil {

                    switch error!.code {
                    case 17011:
                        FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: { (user: FIRUser?, err: NSError?) in
                            if err != nil {
                                print("error during registration \(err?.code)")
                                switch err!.code {
                                case 17026:
                                    self.showErrorAlter("Weak password", msg: "The password you have entered is too weak")
                                    break
                                default:
                                    break
                                }

                            }
                            else {
                                print("reg succeded \(user?.email)")
                                
                                if let userProvider = user?.providerData[0].providerID {
                                    DataService.ds.createUser(user!.uid, provider: userProvider)

                                }
                                
                                //next method should have UID as argument and not email
                                NSUserDefaults.standardUserDefaults().setValue(user?.email, forKey: KEY_UID)
                                let cred = FIREmailPasswordAuthProvider.credentialWithEmail(email, password: password)
                                
                                FIRAuth.auth()?.signInWithCredential(cred, completion: nil)
                                
                                self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                            }
                        })

                        
                        break
                    case 17999:
                        self.showErrorAlter("Invalid email entered", msg: "The email adress you've entered is invalid.")
                        break
                        
                    case 17009:
                        self.showErrorAlter("Invalid password", msg: "The password you've entered is invalid")
                        break
                    default:
                        break
                    }
                    
//                    print(error?.code)
//                    print(error?.localizedDescription)
//                    print(error)
                } else {
                    print("succeded")
                    self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                }
            })
            
        } else {
            showErrorAlter("Email and Password required", msg: "You must enter an email and a password")
        }
        
    }
    func showErrorAlter(titel: String, msg: String){
        let alert = UIAlertController(title: titel, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        
        presentViewController(alert, animated: true, completion: nil)

    }

    
    func createUser() {
    }
}

