//
//  ViewController.swift
//  Note
//
//  Created by Ali on 08/09/20.
//  Copyright © 2020 Ali. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Initialzations
    @IBOutlet weak var noteTableView: UITableView!
    var notesArray = [Note]()
    
    //MARK: -Segue Data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddNoteViewController
        //passes the note and tools to the view controller to update instead of add
        if segue.identifier == "updateNoteSegue"{
            vc.note = notesArray[noteTableView.indexPathForSelectedRow!.row]
            vc.update = true
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    //MARK: - LifeCyvle Hooks
    
    override func viewWillAppear(_ animated: Bool) {
        //Update the notes array
        APIFunctions.functions.fetchNotes()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Update the notes array
        APIFunctions.functions.fetchNotes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        APIFunctions.functions.delegate = self
        //        APIFunctions.functions.fetchNotes()
        
        APIFunctions.functions.delegate = self
        APIFunctions.functions.fetchNotes()
        print(notesArray)
        
        noteTableView.delegate = self
        noteTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    //MARK: - TableViewDelegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath) as! NotePrototypeCell
        //custumize cell to set date
        cell.title.text = notesArray[indexPath.row].title
        cell.note.text = notesArray[indexPath.row].note
        cell.date.text = notesArray[indexPath.row].date
        return cell
    }
    
}

//MARK: -- Custom delegate
protocol DataDelegate {
    func updateArray(newArray: String)
}

extension ViewController: DataDelegate {
    func updateArray(newArray: String) {
        do{
            notesArray = try JSONDecoder().decode([Note].self, from: newArray.data(using: .utf8)!)
            print(notesArray)
        }catch{
            print("Failed to decode")
        }
        self.noteTableView?.reloadData()
    }
}
