mathphreak/ServerlessWebappTemplate
===================================

A somewhat opinionated template for serverless web apps.

Uses CoffeeScript, Jade, and LESS as sources, then compiles using Grunt into JS, HTML, and CSS, respectively.

Comes with jQuery and Bootstrap, with Font Awesome instead of Glyphicons.
Also has Underscore and Backbone.

Usage
-----

    npm install
    grunt

This will automatically compile everything, launch a Web browser pointed to the development server, and recompile and reload as needed.

Then, simply edit any of the files from `src/`.

Configuration
-------------

Make sure you change `name` in `package.json` to the right thing so that all the file names work out.

Deployment
----------

Running `grunt dist` compiles the project and compresses `out/` into `build/` as a `.zip` and a `.tar.gz`.
