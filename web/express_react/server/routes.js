/*
 * Route handling
 */
'use strict';

const express = require('express');
const routesController = require('./controllers/routesController');
const router = express.Router();

// get a random quote from the db
router.get('/something/random', routesController.retrieveRandomSomething);

// get a list of something from the db
router.get('/something', routesController.retrieveSomething);

// add a new quote to the db
router.post('/something', routesController.postSomething);

// update a quote in the db
router.put('/something/:id', routesController.updateSomething);

// delete a quote from the db
router.delete('/something/:id', routesController.deleteSomethinge);

module.exports = router;