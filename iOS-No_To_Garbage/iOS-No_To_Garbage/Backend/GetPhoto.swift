//
//  GetPhoto.swift
//  iOS-No_To_Garbage
//
//  Created by Admin on 26.01.2021.
//

import Foundation
import FirebaseStorage
class GetPhoto{
    
    func setPhoto(path:String, image:UIImage, completion: @escaping (Bool) -> Void) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        var realPath = path
        if path == "Бутылки "{
            realPath = "Бутылки"
        }
        let rand = Int.random(in: 1000000...9999999)
        let imageref = storageRef.child("Garbage").child(realPath).child("\(String(rand)).jpeg")
        let data =  image.jpegData(compressionQuality: 0.5)
        let metaDataForImage = StorageMetadata()
        metaDataForImage.contentType = "image/jpeg"
        imageref.putData(data!, metadata: metaDataForImage) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                completion(false)
                print(error.debugDescription)
                return
            }
            // Metadata contains file metadata such as size, content-type.
            let size = metadata.size
            print(size)
            completion(true)
            
        }
        
        
        
    }
    
    func getPhoto(path:String, completion: @escaping ([UIImage]) -> Void) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        var realPath = path
        if path == "Бутылки "{
            realPath = "Бутылки"
        }
        
        let imageref = storageRef.child("Garbage").child(realPath)
        imageref.listAll { (result, error) in
            var number = 0
            var imageArray:[UIImage] = []
            print("imageArray.count = \(imageArray.count)")
            for item in result.items {
                item.getData(maxSize: 1 * 1024 * 1024) { data, error in
                    if let error = error {
                        print(error)
                    } else {
                        
                        let image = UIImage(data: data!)
                        if image != nil{
                            imageArray.append(image!)
                            if number ==  result.items.count{
                                completion(imageArray)
                            }
                            
                        }
                        
                    }
                }
                number+=1
            }
            
        }
        
        
    }
}
