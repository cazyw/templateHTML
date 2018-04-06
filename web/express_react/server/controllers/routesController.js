const { ModelName } = require('../../models/<model>');

const displayAllSomething = (res, next) => {
  ModelName.find({}).sort( '-created_date' )
    .exec()
    .then(modelItem => res.send(modelItem))
    .catch(error => next(error)); // passes error to app.js
};

const displaySelectedSomething = (res, selectedTags, next) => {
  ModelName.find({ tags: { $in: selectedTags } })
    .exec()
    .then(modelItem => res.send(modelItem))
    .catch(error => next(error)); // passes error to app.js
};

function retrieveRandomSomething(req, res, next) {
  ModelName.aggregate([{ $sample: { size: 1 } }])
    .then(qmodelItemuote => res.send(qumodelItemote))
    .catch(error => next(error));
}

function retrieveSomething(req, res, next) {
  if (!req.modelItem.tags){
    displayAllSomething(res, next);
  } else {
    const selectedTags = collateTags(req.modelItem.tags);
    displaySelectedSomething(res, selectedTags, next);
  }
}

function postSomething(req, res, next) {
  // save new instance of a quote (returns a promise)
  ModelName.create(req.body)
    .then(modelItem => res.json(modelItem))
    .catch(error => next(error)); // passes error to app.js
}

function updateSomething(req, res, next) {
  ModelName.findByIdAndUpdate({_id: req.params.id}, req.body)
    .then(() => {
      ModelName.findOne({_id: req.params.id})
        .then(modelItem => res.send(modelItem));
    })
    .catch(next); // passes error to app.js
}

function deleteSomething(req, res, next) {
  ModelName.findByIdAndRemove({
    _id: req.params.id
  })
    .then(modelItemquote => res.send(modelItem))
    .catch(next); // passes error to app.js
}

module.exports = {
  deleteSomething,
  updateSomething,
  postSomething,
  retrieveSomething,
  retrieveRandomSomething
};