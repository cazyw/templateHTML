
/*
 * Testing routes.js (via app.js)
 */
'use strict';

const expect = require('chai').expect;
const request = require('supertest');
const mongoose = require('mongoose');
const {app} = require('../server/server');
const {ModelName} = require('../models/model');

const MONGO_URI = 'mongodb://localhost/testDatabase';

describe('Routes', () => {
  
  before((done) => {
    if(!mongoose.connection.readyState) {
      mongoose.connect(MONGO_URI).then(() => done());
    } else {
      // console.log('Error: mongodb has not been started. Run mongod --dbpath ~/data/db');
      done();
    }
  });

  after((done) => {
    mongoose.models = {};
    mongoose.modelSchemas = {};
    if(mongoose.connection.db) {
      mongoose.connection.db.dropDatabase();
      done();
    } else {
      done();
    }
  });

  beforeEach(function(done){
    this.timeout(2000);
    ModelName.remove({})
      .then(() => {
        return ModelName.insertMany(modelItems);
      })
      .then(() => done());
  });

  describe('GET /api/<route>', () => {
    
    it('should return all items', (done) => {
      request(app)
        .get('/api/<route>')
        .expect(200)
        .end((err, res) => {
          expect(res.body).to.have.lengthOf(1);
          if (err) return done(err);
          done();
        });
    });

  });

});