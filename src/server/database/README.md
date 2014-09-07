## How to add a new schema
- just add the file to the schemas/ directory and implements the interface defined below

### schema interface
- `module.exports.load()` needs to be defined.
  - it should be used to load the schema into a model in mongoose
