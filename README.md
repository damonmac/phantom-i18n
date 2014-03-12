phantom-i18n
============

compare language text strings and layout for i18n compatibility

getting started
===============

Install [node](http://nodejs.org/) and check out the [phantomjs quick start guide](http://phantomjs.org/quick-start.html).  You can install phantomjs globally with:

     $ npm install phantomjs -g

To gather the pages for each language:

     $ phantomjs getpages.coffee

analyzing results
=================

Look in the png folder and compare screen images (width is controlled in the script).  Compare text strings that print out together.
