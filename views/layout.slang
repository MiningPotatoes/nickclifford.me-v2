doctype html
html
  head
    title Nick Clifford | #{title}
    script src="https://use.fontawesome.com/f044d6a94c.js"
    link rel="icon" href="/images/me.png"
    link rel="stylesheet" href="https://cdn.rawgit.com/konpa/devicon/master/devicon.min.css"
    link rel="stylesheet" href="https://cdn.rawgit.com/allienworks/cryptocoins/master/webfont/cryptocoins.css"
    link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400|Roboto:100,300,400"
    == stylesheet
  body
    == content
    - Dir.glob("./public/javascripts/polyfills/*.js") do |polyfill|
      script src="/javascripts/polyfills/#{File.basename(polyfill)}"
