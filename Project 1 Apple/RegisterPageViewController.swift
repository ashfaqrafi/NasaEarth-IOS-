//
//  RegisterPageViewController.swift
//  Project 1 Apple
//
//  Created by Sanzid Ashan on 4/9/16.
//  Copyright © 2016 Sanzid Ashan. All rights reserved.
//

import UIKit
//import Parse


class RegisterPageViewController: UIViewController {
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func registerButtonTapped(sender: AnyObject) {
        
        let userEmail = userEmailTextField.text;
        let userPassword = userPasswordTextField.text;
        let userRepeatPassword = repeatPasswordTextField.text;
        
        // Check for empty fields
        if(userEmail!.isEmpty || userPassword!.isEmpty || userRepeatPassword!.isEmpty)
        {
            
            // Display alert message
            
            displayMyAlertMessage("All fields are required");
            
            return;
        }
        
        //Check if passwords match
        if(userPassword != userRepeatPassword)
        {
            // Display an alert message
            displayMyAlertMessage("Passwords do not match");
            return;
            
        }
        
        
        
        
        // Store data
        NSUserDefaults.standardUserDefaults().setObject(userEmail, forKey: "userEmail");
        NSUserDefaults.standardUserDefaults().setObject(userPassword, forKey: "userPassword");
        NSUserDefaults.standardUserDefaults().synchronize();
        
        // Display alert message with confirmation.
        let myAlert = UIAlertController(title:"Alert", message:"Registration is successful. Thank you!", preferredStyle: UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.Default){ action in
            self.dismissViewControllerAnimated(true, completion:nil);
        }
        
        myAlert.addAction(okAction);
        self.presentViewController(myAlert, animated:true, completion:nil);
        
        
    }
    
    
    
    
    
    



func displayMyAlertMessage(userMessage:String)
{
    
    let myAlert = UIAlertController(title:"Alert", message:userMessage, preferredStyle: UIAlertControllerStyle.Alert);
    
    let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.Default, handler:nil);
    
    myAlert.addAction(okAction);
    self.presentViewController(myAlert, animated: true, completion: nil);
    

}
}