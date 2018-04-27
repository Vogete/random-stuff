/* jshint esversion: 6 */
const express = require('express');
const router = express.Router();
const MongoClient = require('mongodb').MongoClient;
const ObjectID = require('mongodb').ObjectID;

// Connect to mongodb
const connection = (closure) => {
    return MongoClient.connect('mongodb://localhost:27017', (err, client) => {
        if (err) {
            return console.log(err);
        }

        //Since MongoDB 3.x, the db name is specified like this, not in the connection URL
        let db = client.db("mean");

        closure(db);
    });
};

// error handling
const sendError = (err, res) => {
    response.status = 501;
    response.message = typeof err == 'object' ? err.message : err;
    res.status(501).json(response);
};

// response handling
let response = {
    status: 200,
    data: [],
    message: null
};

// get users
router.get('/users', (req, res) => {
    connection((db) => {
        db.collection('users')
            .find()
            .toArray()
            .then((users) => {
                response.data = users;
                res.json(response);
            })
            .catch((err) => {
                sendError(err, res);
            });

    });
});

module.exports = router;
