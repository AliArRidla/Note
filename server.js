const express = require('express')
const mongoose = require('mongoose')
var Data = require('./noteSchema')
const app = express()

mongoose.connect('mongoDB://localhost/newDB')

mongoose.connection.once("open",() => {
    console.log("Connected to database")
}).on("error",(error) => {
    console.log("failed to connect")
})

// CREATE A NOTE 
// POST REQUEST
app.post("/create",(req,res) => {

    var note = new Data({
        note: req.get("note"),
        title: req.get("title"),
        date: req.get("date"),
    })

    note.save().then(() => {
        if (note.isNew == false ){
            console.log ("Saved data!")
            res.send("Saved data!")
        }else {
            console.log("Failed to save data")
        }
    })

})

// FETCH ALL NOTES
// GET REQUEST
// http://192.168.210.69/fetch
app.get('/fetch', (req,res) => {
    Data.find({}).then((DBitems) => {
        res.send(DBitems)
    })
})

// DELETE A NOTE
// POST REQUEST
app.post("/delete",(req,res) => {
    Data.findOneAndRemove({
        _id: req.get("id")
    }, (err) => {
        console.log("Failed" + err)
    })
    res.send("Deleted!")
})

// http://192.168.210.69/create
server = app.listen(8081, "192.168.211.106", () => {
    console.log("Server is running")
})


// UPDATE A NOTE
app.post("/update",(req, res) => {
    Data.findOneAndUpdate({
        _id: req.get("id")
    },{
        note: req.get("note"),
        title: req.get("title"),
        date: req.get("date")
    }, (err) => {
        console.log("failed update" + err)
    })
    res.send("Updated")


})