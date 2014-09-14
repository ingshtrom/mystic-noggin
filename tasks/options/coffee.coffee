###
  configuration for "coffee" tasks
  @module mystic-noggin
  @submodule Gruntfile
  @task coffee
###
module.exports =
  glob_to_multiple:
    expand: true
    cwd: "<%= gruntConfig.srcDir %>"
    src: ["**/*.coffee"]
    dest: "<%= gruntConfig.pubDir %>"
    ext: ".js"
