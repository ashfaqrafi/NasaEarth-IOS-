//
//  ViewController2.swift
//  Project 1 Apple
//
//  Created by Sanzid Ashan on 4/18/16.
//  Copyright © 2016 Sanzid Ashan. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate  {

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var uploadButton: UIButton!
    var imagePicker: UIImagePickerController!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func uploadButtonTapped(sender: AnyObject) {
        
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(myPickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        myImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        myImageView.backgroundColor = UIColor.clearColor()
        self.dismissViewControllerAnimated(true, completion: nil)
        
        uploadImage()
        
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        myImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
    }
    
    func uploadImage()
    {
        let imageData = UIImageJPEGRepresentation(myImageView.image!, 1)
        
        if(imageData == nil )  { return }
        
        self.uploadButton.enabled = false
        
        
        let uploadScriptUrl = NSURL(string:"http://127.0.0.1/Sanzid/upload_file.php")
        let request = NSMutableURLRequest(URL: uploadScriptUrl!)
        request.HTTPMethod = "POST"
        request.setValue("Keep-Alive", forHTTPHeaderField: "Connection")
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        
        
        let task = session.uploadTaskWithRequest(request, fromData: imageData!)
        task.resume()
        
    }
    
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?)
    {
        let myAlert = UIAlertView(title: "Alert", message: error?.localizedDescription, delegate: nil, cancelButtonTitle: "Ok")
        myAlert.show()
        
        self.uploadButton.enabled = true
        
    }
    
    
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveResponse response: NSURLResponse, completionHandler: (NSURLSessionResponseDisposition) -> Void)
    {
        self.uploadButton.enabled = true
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
