module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    # Task configuration.
    coffee:
      compileDev:
        options:
          sourceMap: no
        files:
          "out/js/main.js": "src/coffee/*.coffee"
      compile:
        files:
          "out/js/main.js": "src/coffee/*.coffee"
    connect:
      serveDev:
        options:
          base: "out"
          open: yes
          livereload: yes
    concat:
      libraries:
        files:
          "out/js/libs.js": [
            "lib/js/jquery/jquery-2.0.3.js"
            "lib/js/bootstrap/tooltip.js"
            "lib/js/bootstrap/*"
            "lib/js/underscore/*"
            "lib/js/backbone/*"
          ]
    jade:
      compileDev:
        options:
          pretty: yes
        files:
          "out/index.html": "src/jade/*.jade"
    less:
      options:
        sourceMap: yes
        outputSourceFiles: yes
      compileBootstrap:
        options:
          sourceMapFilename: "out/css/bootstrap.css.map"
          sourceMapURL: "bootstrap.css.map"
        files:
          "out/css/bootstrap.css": "src/less/bootstrap/bootstrap.less"
      compileFontAwesome:
        options:
          sourceMapFilename: "out/css/font-awesome.css.map"
          sourceMapURL: "font-awesome.css.map"
        files:
          "out/css/font-awesome.css": "src/less/font-awesome/font-awesome.less"
      compileDev:
        options:
          sourceMapFilename: "out/css/main.css.map"
          sourceMapURL: "main.css.map"
        files:
          "out/css/main.css": ["src/less/*.less"]
    copy:
      assets:
        files: [
          {
            expand: true
            cwd: "lib/assets/"
            src: "**/*"
            dest: "out/assets/"
          }
        ]
    clean:
      out: ["out/"]
      build: ["build/"]
    watch:
      coffee:
        files: ["src/coffee/*.coffee"]
        tasks: ["coffee:compileDev"]
      jade:
        files: ["src/jade/*.jade"]
        tasks: ["jade"]
      less:
        files: ["src/less/*.less"]
        tasks: ["less"]
      livereload:
        files: ["out/**"]
        options: livereload: true
    compress:
      options:
        pretty: true
      zip:
        options:
          archive: "build/<%= pkg.name %>-<%= grunt.template.today('yyyy-mm-dd') %>.zip"
          mode: "zip"
        files: [
          expand: yes, cwd: "out/", src: "**", dest: ""
        ]
      tgz:
        options:
          archive: "build/<%= pkg.name %>-<%= grunt.template.today('yyyy-mm-dd') %>.tar.gz"
          mode: "tgz"
        files: [
          expand: yes, cwd: "out/", src: "**", dest: ""
        ]

  # These plugins provide necessary tasks.
  grunt.loadNpmTasks("grunt-contrib-coffee")
  grunt.loadNpmTasks("grunt-contrib-watch")
  grunt.loadNpmTasks("grunt-contrib-less")
  grunt.loadNpmTasks("grunt-contrib-jade")
  grunt.loadNpmTasks("grunt-contrib-connect")
  grunt.loadNpmTasks("grunt-contrib-concat")
  grunt.loadNpmTasks("grunt-contrib-copy")
  grunt.loadNpmTasks("grunt-contrib-clean")
  grunt.loadNpmTasks("grunt-contrib-compress")

  # Default task.
  grunt.registerTask('default', ["clean:out", "coffee:compileDev", "jade:compileDev", "less", "concat:libraries", "copy", "connect:serveDev", "watch"])
  grunt.registerTask('dist', ["clean", "coffee:compileDev", "jade:compileDev", "less", "concat:libraries", "copy", "compress"])
