//
//  ViewController.swift
//  FacebookIntegrationPractice
//
//  Created by vamshi on 07/09/18.
//  Copyright © 2018 vamshi. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    var loginManagerObj = LoginManager()
    
    @IBAction func onLogOutTapped(_ sender: Any)
    {
        
        loginManagerObj.logOut()
        
        
    }
    
    @IBAction func onLoginTapped(_ sender: UIButton)
    {
        
        
        loginManagerObj.logIn(readPermissions: [.publicProfile,.email], viewController: self)
        {
            (loginResult) in
            
            switch loginResult
            {
                
            case .failed(let error):
                print(error.localizedDescription)
                break
                
                
            case .cancelled:
                print("user cancelled")
                break
                
                
            case .success(grantedPermissions: let grantedPermissions, declinedPermissions: let declinedPermissions, token: let accessTokens):
                
                print("grantedPermissions is \(grantedPermissions)")
                print("declinedPermissions is \(declinedPermissions)")
                print("accessTokens is \(accessTokens)")
                
                let para = ["fields":"name,id,email,first_name,last_name,picture.type(large)"]
                
                GraphRequest.init(graphPath: "me", parameters: para, accessToken: accessTokens).start(
                    {
                        (resp, result) in
                        
                        
                        
                        print("result is \(result)")
                        
                        switch result
                        {
                            
                        case .failed(let error):
                            print(error.localizedDescription)
                            break
                            
                        case .success(response: let grphResp):
                            
                            if let respDict = grphResp.dictionaryValue
                            {
                                print("Name =====\(respDict["name"]!)")
                                print("FirstName =====\(respDict["first_name"]!)")
                                print("LastName =====\(respDict["last_name"]!)")
                                print("Picture =====\(respDict["picture"]!)")
                                
                                
                                
                                
                                
                                
                                let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                                //   homeVC.arr = [respDict as Any]
                                
                                //   print("name is ***** \(homeVC.arr[0])")
                                
                                self.navigationController?.pushViewController(homeVC, animated: true)
                                
                            }
                            
                            
                            
                            
                            
                        }
                        
                })
                
                break
                
                
                
                
                
            }
            
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
}

