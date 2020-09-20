//
//  APIFunctions.swift
//  Note
//
//  Created by Ali on 19/09/20.
//  Copyright © 2020 Ali. All rights reserved.
//

import Foundation
import Alamofire

//MARK: -Custom note struct
struct Note:Decodable {
    var title : String
    var date : String
    var _id : String
    var note : String
}

//MARK: - Functions that interact with APIs
class APIFunctions {
    
    //Set our custom data delegate
    var delegate : DataDelegate?
    //Create am instance of the class so the other files can interact with it
    static let functions = APIFunctions()
    
    //fetches note from database
    func fetchNotes() {
        AF.request("http://192.168.211.106:8081/fetch").response { response in
            
            print(response.data)
            //            convert the response into utf8 string format
            let data = String(data: response.data!, encoding: .utf8)
            //            fires off the custom delegate in the view controller
            self.delegate?.updateArray(newArray: data!)
        }
    }
    
    //    Add a notes to the server, passing the argumenst as header
    func AddNote(date: String, title: String,note: String){
        AF.request("http://192.168.211.106:8081/create",method: .post,encoding: URLEncoding.httpBody, headers: ["title" : title,"date": date,"note":note]).responseJSON {
            response in
            print(response)
        }
    }
    
    //    updates a note to yhe server ,passing arguments as header
    func UpdateNote(date: String, title: String,note: String,id:String ){
        AF.request("http://192.168.211.106:8081/update",method: .post,encoding: URLEncoding.httpBody, headers: ["title" : title,"date": date,"note":note, "id":id]).responseJSON {
            response in
            print(response)
        }
    }
    //    delete a note the server, passing note id as header
    func DeleteNote(id:String ){
        AF.request("http://192.168.211.106:8081/delete",method: .post,encoding: URLEncoding.httpBody, headers: ["id":id]).responseJSON {
            response in
            print(response)
        }
    }
    
}
