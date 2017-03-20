# Setting

Since we don't know what your favorite programming language(s) is/are, we will give you all the freedom to choose.

Please, in the end, send us a compressed file with the whole solution/project **including** the .git folder (so we can see your commit history).


# Goals

* the goal in the end is to print all the image URLs from the first 120 products in http://muenchen.bringmeister.de/obst-gemuse.html. collect these links and output them (e.g. in JSON format) to STDOUT at the end of your program.

* please try to get at the image URLs with both XPath and CSS selectors. do use either solution, and comment out the other (but make sure both actually work).

* add meaningful error handling for 2 cases:
  * the server responds with a 4xx/5xx response
  * an individual product does not have some HTML-tag that you assumed to exist.

  * in both cases, backtraces should be logged to STDOUT.


* log to STDOUT
  * the request URL (before a request is being started).
  * the time a request took (after the request is finished).


* add a single test case
  * for one response, save a version of the response HTML to the tests folder
  * keep only a few products in the HTML (maybe 3 or so), delete the others
  * write a test that parses the HTML, and passes it to your component
  * test that for the 3 products the image-URLs are correctly found and output.


* document in the README
  * how the test case can be run
  * how the actual script/program can be run
  * how to install any prerequisites


# Extra Goals

* instead of sending the logs to STDOUT, send them to
  * https://simploratrials.loggly.com/sources/setup/ruby-app-setup
  * ( you will receive the credentials via Slack )

* instead of raising and logging the backtraces to STDOUT
  * send the entire exception/error to http://docs.honeybadger.io/lib/ruby.html according to the documentation
  * ( also for honeybadger you will receive the credentials via Slack. )

* instead of logging the time the request took, send it to datadog
  * install the agent
  * use https://github.com/Shopify/statsd-instrument with `StatsD.backend = StatsD::Instrument::Backends::UDPBackend.new` and everything should work just fine (because the DataDog agent already listens on the default port of `localhost:8125`)


# Bonus

* describe how the HTTP library of your choice handles redirects. what does it do for
  * 301, 302 respectively ?
  * meta-tag redirects ?
  * https->http redirects ?
  * relative redirects in the "Location" header ?
* does it keep cookies for subsequent requests ?


# Tips & Tricks

* you can use https://httpie.org/ to possibly get a more human-friendly output of HTTP interactions.
* open your Chrome Dev Tools in order to record all the Network traffic, and filter for relevant requests
* use `$x()` and `$$()` to execute XPath and CSS selectors in the Chrome Dev Tools, respectively.
* for the Bonus Task: if the documentation or source code does not tell you, you can try and find out with the help of https://httpbin.org/
