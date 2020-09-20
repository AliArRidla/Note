//
//  AddNoteViewController.swift
//  Note
//
//  Created by Ali on 19/09/20.
//  Copyright © 2020 Ali. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    //MARK: Initializations
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var bodyTextView: UITextView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    var note:Note?
    var update = false
    
    //MARK: - UI Buttons
    @IBAction func deleteAction(_ sender: Any) {
        APIFunctions.functions.DeleteNote(id: note!._id)
        //return the screen back to main screen
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func saveClick(_ sender: Any) {
        //create a date string that we can pass in to the database
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: Date())
        
        // if the user is updating ,update the note rather than saving
        if update == true {
            APIFunctions.functions.UpdateNote(date: date, title: titleTextField.text!, note: bodyTextView.text, id: note!._id)
            self.navigationController?.popViewController(animated: true)
        } else if titleTextField.text != "" && bodyTextView.text != "" {
            APIFunctions.functions.AddNote(date: date, title: titleTextField.text!, note: bodyTextView.text)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK: -Life Cycle Hooks
    override func viewWillAppear(_ animated: Bool) {
        //disabel delete battle if user is adding a note
        if update == false {
            self.deleteButton.isEnabled = false
            self.deleteButton.title = "" 
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Prepopulates the text field is the user i updating the note
        if update == true {
            titleTextField.text = note?.title
            bodyTextView.text = note?.note
        }
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
