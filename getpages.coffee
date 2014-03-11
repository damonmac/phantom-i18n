webpage = require('webpage')
fs = require('fs')
textOut = {}

# langs = ['en', 'es']
# TODO: headers are variable through optimizely - yikes!!
langs = ['en', 'es', 'pt', 'de', 'ru', 'fr', 'it', 'zh', 'ja', 'ko']

follow = (lang, callback) ->

  page = webpage.create()
  page.customHeaders =
    'Accept-Language': lang

  page.viewportSize =
    width: 1024
    height: 800

  page.open 'https://beta.familysearch.org/pal:/MM9.1.1/VRZF-CYG', (status) ->

    if status isnt 'success'
      console.log "error loading page"
    else
      # page.evaluate ->
      #   document.querySelector('input[name=nickname]').value = 'phantom'
      #   document.querySelector('input[name=disclaimer_agree]').click()
      #   document.querySelector('form').submit()

      window.setTimeout -> # give it 3 seconds to load completely all the ajax elements
        console.log "opened " + lang

        # page.onConsoleMessage = (msg) ->
        #   console.log msg
        
        # save a picture of the page
        page.render('png/' + lang + '.png')

        # cleanup extra spaces in output
        text = page.plainText.replace(/^\n/gm, '')
        fs.write('text/' + lang + '.txt', text, 'w')

        # stub in 'volunteer' that doesn't exist in korean and chinese
        if lang is 'zh' or lang is 'ko'
          text = "XXX\n" + text

        textOut[lang] = text.split("\n")
        page.close()
        callback.apply()
      , 3000

process = -> # make the execution synchronous
  lang = langs.shift()
  unless lang
    for string, i in textOut['en']
      console.log string + '\n' + textOut['es'][i] + '\n' + textOut['pt'][i] + '\n' + 
      textOut['fr'][i] + '\n' + textOut['de'][i] + '\n' + textOut['ru'][i] + '\n' + 
      textOut['it'][i] + '\n' + textOut['zh'][i] + '\n' + textOut['ja'][i] + '\n' + textOut['ko'][i] + '\n'
    phantom.exit()
  follow lang, process

process()
