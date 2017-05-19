//
//  ViewController.swift
//  W07_FileManager_NIT
//
//  Created by Cntt16 on 5/19/17.
//  Copyright © 2017 Cntt16. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var fileManager: FileManager?
    var filePath: NSString?
    var documentDir: NSString?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnCreateFileClicked(_ sender: Any) {
        filePath = documentDir?.appendingPathComponent("file1.txt") as NSString?
        fileManager?.createFile(atPath: filePath! as String, contents: nil, attributes: nil)
        filePath = documentDir?.appendingPathComponent("file2.txt") as NSString?
        fileManager?.createFile(atPath: filePath! as String, contents: nil, attributes: nil)
        self.showSuccessAlert(titleAlert: "Success", messageAlert: "File created successfully")
    }
    
    func showSuccessAlert(titleAlert:NSString,messageAlert:NSString)
    {
        let alert:UIAlertController = UIAlertController(title:titleAlert as String, message: messageAlert as String, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
        }
        alert.addAction(okAction)
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnCreateDirectoryClicked(sender: AnyObject)
    {
        filePath = documentDir?.appendingPathComponent("/folder1") as NSString?
        do {
            try fileManager?.createDirectory(atPath: filePath! as String, withIntermediateDirectories: false, attributes: nil)
        } catch let error as NSError {
            print(error)
        }
        self.showSuccessAlert(titleAlert: "Success", messageAlert: "Directory created successfully")
    }
    
    @IBAction func btnEqualityClicked(sender: AnyObject)
    {
        let filePath1 = documentDir?.appendingPathComponent("temp.txt")
        let filePath2 = documentDir?.appendingPathComponent("copy.txt")
        if(fileManager?.contentsEqual(atPath: filePath1!, andPath: filePath2!))!
        {
            self.showSuccessAlert(titleAlert: "Message", messageAlert: "Files are equal.")
        }
        else
        {
            self.showSuccessAlert(titleAlert: "Message", messageAlert: "Files are not equal.")
        }
    }
    
    @IBAction func btnWriteFileClicked(sender: AnyObject)
    {
        let content:NSString = NSString(string: "helllo how are you?")
        let fileContent:NSData = content.data(using: String.Encoding.utf8.rawValue)! as NSData
        fileContent.write(toFile: (documentDir?.appendingPathComponent("file1.txt"))!, atomically: true)
        self.showSuccessAlert(titleAlert: "Success", messageAlert: "Content written successfully")
    }
    
    @IBAction func btnReadFileClicked(sender: AnyObject)
    {
        filePath =
            
            documentDir?.appendingPathComponent("/new/file1.txt") as NSString?
        var fileContent:NSData?
        fileContent=fileManager?.contents(atPath: filePath! as String) as NSData?
        let str:NSString=NSString(data: fileContent! as Data, encoding: String.Encoding.utf8.rawValue)!
        self.showSuccessAlert(titleAlert: "Success", messageAlert: "data : \(str)" as NSString)
    }
    
    @IBAction func btnCopyFileClicked(sender: AnyObject)
    {
        filePath = documentDir?.appendingPathComponent("temp.txt") as! NSString
        let originalFile=documentDir?.appendingPathComponent("temp.txt")
        let copyFile=documentDir?.appendingPathComponent("copy.txt")
        try? fileManager?.copyItem(atPath: originalFile!, toPath: copyFile!)
        self.showSuccessAlert(titleAlert: "Success", messageAlert:"File copied successfully")
    }
    
    @IBAction func btnMoveClicked(sender: AnyObject)
    {
        let oldFilePath:String=documentDir!.appendingPathComponent("/folder1/move.txt") as String
        let newFilePath:String=documentDir!.appendingPathComponent("temp.txt") as String
        do {
            try fileManager?.moveItem(atPath: oldFilePath, toPath: newFilePath)
        }
        catch let err as NSError
        {
            print("errorr \(err)")
        }
        
        self.showSuccessAlert(titleAlert: "Success", messageAlert: "File moved successfully")
    }
    
    @IBAction func btnFilePermissionClicked(_ sender: Any) {
        filePath = documentDir?.appendingPathComponent("file1.txt") as NSString?
        var filePermissions:NSString = ""
        
        if((fileManager?.isWritableFile(atPath: filePath! as String)) != nil)
        {
            filePermissions = filePermissions.appending("file is writable. ") as NSString
        }
        if((fileManager?.isReadableFile(atPath: filePath! as String)) != nil)
        {
            filePermissions = filePermissions.appending("file is readable. ") as NSString
        }
        if((fileManager?.isExecutableFile(atPath: filePath! as String)) != nil)
        {
            filePermissions = filePermissions.appending("file is executable.") as NSString
        }
        self.showSuccessAlert(titleAlert: "Success", messageAlert: "\(filePermissions)" as NSString)
    }
    
    @IBAction func btnDirectoryContentsClicked(_ sender: Any) {
        do {
            let arrDirContent = try fileManager!.contentsOfDirectory(atPath: filePath! as String)
            self.showSuccessAlert(titleAlert: "Success", messageAlert: "Content of directory \(arrDirContent)" as NSString)
        }
        catch let error as NSError {
            print(error)
        }
    }
    
    @IBAction func btnRemoveFile(_ sender: Any) {
        filePath = documentDir?.appendingPathComponent("file1.txt") as! NSString
        try? fileManager?.removeItem(atPath: filePath! as String)
        self.showSuccessAlert(titleAlert: "Message", messageAlert: "File removed successfully.")
    }
    
    
}

