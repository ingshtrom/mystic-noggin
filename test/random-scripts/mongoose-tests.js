module.exports.run = function() {
  // just running the Getting Started
  // from http://mongoosejs.com/docs/index.html
  var mongoose = require('mongoose');
  mongoose.connect('mongodb://localhost/test');

  var db = mongoose.connection;
  db.on('error', console.error.bind(console, 'connection error:'));
  db.once('close', function() { console.log('closed connection to database'); });
  db.once('open', function() {
    console.log('opened connection to database');

    var kittySchema = mongoose.Schema({
      name: String
    });

    // NOTE: methods must be added to the schema before compiling it with mongoose.model()
    kittySchema.methods.speak = function() {
      var greeting = this.name ? "Meow name is " + this.name : "I don't have a name";
      console.log(greeting);
    };

    var Kitten = mongoose.model('Kitten', kittySchema);

    var silence = new Kitten({ name: 'Silence' });
    console.log(silence.name);

    var fluffy = new Kitten({ name: 'Fluffy' });
    fluffy.speak();
    fluffy.save(function (err, fluffy) {
      console.log('saving ' + this.name);
      if (err) {
        return console.error(err);
      }
      fluffy.speak();
    });

    Kitten.find(function (err, kittens) {
      if (err) return console.error(err);
      console.log(kittens);
    });
    setTimeout(function() {
      db.close();
    }, 5000);
  });
};
