//
//  SendToDBModel.swift
//  ChatApp
//
//  Created by 小林　将太 on 2021/06/17.
//

import Foundation
import FirebaseStorage

protocol SendProfileOKDelegate {
    
    func sendProfileOKDelegate(url: String)
    
}

class SendToDBModel {
    
    var sendProfileOKDelegate: SendProfileOKDelegate?
    
    init() {
        
    }
    
    func sendProfileImageData(data: Data) {
        
        let image = UIImage(data: data)
        let profileImageData = image?.jpegData(compressionQuality: 0.1)
        
        let imageRef = Storage.storage().reference().child("profileImage").child("\(UUID().uuidString + String(Date().timeIntervalSince1970)).jpg")
        
        imageRef.putData(profileImageData!, metadata: nil, completion: {(metadata, error) in
            
            if error != nil {
                
                print(error.debugDescription)
                return
            }
            
            imageRef.downloadURL {(url, error) in
                
                if error != nil {
                    
                    print(error.debugDescription)
                    return
                }
                
                UserDefaults.standard.setValue(url?.absoluteString, forKey: "userImage")
                self.sendProfileImageData(data: data)
            }
        })
    }
}
