# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
    if $("body").hasClass("static_pages_quote_builder")
        $("#emoticons_row").css("marginTop", $("#builder_row").outerHeight() - 10);
        Unicode.initialize_font_selector()
        builder = document.getElementById("builder")
        $(".eu").click ->
            insert_at_caret_2(builder, $('<div/>').html(this.innerHTML).text())
            return
        builder.onkeypress = (key) ->
            alpha = String.fromCharCode(key.charCode)
            if !/[^a-zA-Z]/.test(alpha)
                insert_at_caret_2(builder, Unicode.get_char(alpha))
                return false

$(document).ready ready
$(document).on "page:load", ready

object_notation_generator = (alpha) ->
  builder = (char1, char2) ->
    "\"" + char1 + "\" : \"" + char2 + "\""
  return_string = ""
  character = "a"
  i = 0

  while i < 25
    return_string += builder(character, alpha.charAt(i)) + ",\n"
    return_string += builder(character.toUpperCase(), alpha.charAt(i + 26)) + ",\n"
    character = String.fromCharCode(character.charCodeAt() + 1)
    i++
  return_string += builder("z", alpha.charAt(25)) + ",\n"
  return_string += builder("Z".toUpperCase(), alpha.charAt(51))
  return_string

insert_at_caret = (text_area, text) ->
  scroll_pos = text_area.scrollTop
  str_pos = 0
  br = ((if (text_area.selectionStart or text_area.selectionStart is "0") then "ff" else ((if document.selection then "ie" else false))))
  if br is "ie"
    text_area.focus()
    range = document.selection.createRange()
    range.moveStart "character", -text_area.value.length
    str_pos = range.text.length
  else str_pos = text_area.selectionStart  if br is "ff"
  front = (text_area.value).substring(0, str_pos)
  back = (text_area.value).substring(str_pos, text_area.value.length)
  text_area.value = front + text + back
  str_pos = str_pos + text.length
  if br is "ie"
    text_area.focus()
    range = document.selection.createRange()
    range.moveStart "character", -text_area.value.length
    range.moveStart "character", str_pos
    range.moveEnd "character", 0
    range.select()
  else if br is "ff"
    text_area.selectionStart = str_pos
    text_area.selectionEnd = str_pos
    text_area.focus()
  text_area.scrollTop = scroll_pos
  return

insert_at_caret_2 = (text_area, text) ->
  old
  unless text_area.selectionStart is text_area.selectionEnd
    old = text_area.selectionStart
  else
    old = text_area.selectionEnd
  text_area.value = text_area.value.substr(0, text_area.selectionStart) + text + text_area.value.substr(text_area.selectionEnd)
  text_area.selectionEnd = old + text.length
  text_area.selectionStart = old + text.length
  return

Unicode = (->
  current = "Small Caps"
  unicode_fonts = { "Normal" : { "sample" : "aAbBcCdD" } }
  unicode_fonts["Small Caps"] =
    sample: "ᴀᴀʙʙᴄᴄᴅᴅ"
    a: "ᴀ"
    A: "ᴀ"
    b: "ʙ"
    B: "ʙ"
    c: "ᴄ"
    C: "ᴄ"
    d: "ᴅ"
    D: "ᴅ"
    e: "ᴇ"
    E: "ᴇ"
    f: "ꜰ"
    F: "ꜰ"
    g: "ɢ"
    G: "ɢ"
    h: "ʜ"
    H: "ʜ"
    i: "ɪ"
    I: "ɪ"
    j: "ᴊ"
    J: "ᴊ"
    k: "ᴋ"
    K: "ᴋ"
    l: "ʟ"
    L: "ʟ"
    m: "ᴍ"
    M: "ᴍ"
    n: "ɴ"
    N: "ɴ"
    o: "ᴏ"
    O: "ᴏ"
    p: "ᴩ"
    P: "ᴩ"
    q: "q"
    Q: "Q"
    r: "ʀ"
    R: "ʀ"
    s: "ꜱ"
    S: "ꜱ"
    t: "ᴛ"
    T: "ᴛ"
    u: "ᴜ"
    U: "ᴜ"
    v: "ᴠ"
    V: "ᴠ"
    w: "ᴡ"
    W: "ᴡ"
    x: "x"
    X: "x"
    y: "y"
    Y: "Y"
    z: "ᴢ"
    Z: "ᴢ"

  unicode_fonts["Circled"] =
    sample: "ⓐⒶⓑⒷⓒⒸⓓⒹ"
    a: "ⓐ"
    A: "Ⓐ"
    b: "ⓑ"
    B: "Ⓑ"
    c: "ⓒ"
    C: "Ⓒ"
    d: "ⓓ"
    D: "Ⓓ"
    e: "ⓔ"
    E: "Ⓔ"
    f: "ⓕ"
    F: "Ⓕ"
    g: "ⓖ"
    G: "Ⓖ"
    h: "ⓗ"
    H: "Ⓗ"
    i: "ⓘ"
    I: "Ⓘ"
    j: "ⓙ"
    J: "Ⓙ"
    k: "ⓚ"
    K: "Ⓚ"
    l: "ⓛ"
    L: "Ⓛ"
    m: "ⓜ"
    M: "Ⓜ"
    n: "ⓝ"
    N: "Ⓝ"
    o: "ⓞ"
    O: "Ⓞ"
    p: "ⓟ"
    P: "Ⓟ"
    q: "ⓠ"
    Q: "Ⓠ"
    r: "ⓡ"
    R: "Ⓡ"
    s: "ⓢ"
    S: "Ⓢ"
    t: "ⓣ"
    T: "Ⓣ"
    u: "ⓤ"
    U: "Ⓤ"
    v: "ⓥ"
    V: "Ⓥ"
    w: "ⓦ"
    W: "Ⓦ"
    x: "ⓧ"
    X: "Ⓧ"
    y: "ⓨ"
    Y: "Ⓨ"
    z: "ⓩ"
    Z: "Ⓩ"

  unicode_fonts["Fullwidth"] =
    sample: "ａＡｂＢｃＣｄＤ"
    a: "ａ"
    A: "Ａ"
    b: "ｂ"
    B: "Ｂ"
    c: "ｃ"
    C: "Ｃ"
    d: "ｄ"
    D: "Ｄ"
    e: "ｅ"
    E: "Ｅ"
    f: "ｆ"
    F: "Ｆ"
    g: "ｇ"
    G: "Ｇ"
    h: "ｈ"
    H: "Ｈ"
    i: "ｉ"
    I: "Ｉ"
    j: "ｊ"
    J: "Ｊ"
    k: "ｋ"
    K: "Ｋ"
    l: "ｌ"
    L: "Ｌ"
    m: "ｍ"
    M: "Ｍ"
    n: "ｎ"
    N: "Ｎ"
    o: "ｏ"
    O: "Ｏ"
    p: "ｐ"
    P: "Ｐ"
    q: "ｑ"
    Q: "Ｑ"
    r: "ｒ"
    R: "Ｒ"
    s: "ｓ"
    S: "Ｓ"
    t: "ｔ"
    T: "Ｔ"
    u: "ｕ"
    U: "Ｕ"
    v: "ｖ"
    V: "Ｖ"
    w: "ｗ"
    W: "Ｗ"
    x: "ｘ"
    X: "Ｘ"
    y: "ｙ"
    Y: "Ｙ"
    z: "ｚ"
    Z: "Ｚ"

  unicode_fonts["Modifier Letter Small"] =
    sample: "ᵃᴬᵇᴮᶜCᵈᴰ"
    a: "ᵃ"
    A: "ᴬ"
    b: "ᵇ"
    B: "ᴮ"
    c: "ᶜ"
    C: "C"
    d: "ᵈ"
    D: "ᴰ"
    e: "ᵉ"
    E: "ᴱ"
    f: "ᶠ"
    F: "F"
    g: "ᵍ"
    G: "ᴳ"
    h: "ʰ"
    H: "ᴴ"
    i: "ᶤ"
    I: "ᴵ"
    j: "ʲ"
    J: "ᴶ"
    k: "ᵏ"
    K: "ᴷ"
    l: "ˡ"
    L: "ᶫ"
    m: "ᵐ"
    M: "ᴹ"
    n: "ᶯ"
    N: "ᶰ"
    o: "ᵒ"
    O: "ᴼ"
    p: "ᵖ"
    P: "ᴾ"
    q: "q"
    Q: "Q"
    r: "ʳ"
    R: "ᴿ"
    s: "ˢ"
    S: "S"
    t: "ᵗ"
    T: "ᵀ"
    u: "ᵘ"
    U: "ᵁ"
    v: "ᵛ"
    V: "ⱽ"
    w: "ʷ"
    W: "X"
    x: "ˣ"
    X: "ᵂ"
    y: "ʸ"
    Y: "Y"
    z: "ᶻ"
    Z: "Z"

  unicode_fonts["Upside Down"] =
    sample: "ɐɐqqɔɔpp"
    a: "ɐ"
    A: "ɐ"
    b: "q"
    B: "q"
    c: "ɔ"
    C: "ɔ"
    d: "p"
    D: "p"
    e: "ǝ"
    E: "ǝ"
    f: "ɟ"
    F: "ɟ"
    g: "ƃ"
    G: "ƃ"
    h: "ɥ"
    H: "ɥ"
    i: "ı"
    I: "ı"
    j: "ɾ"
    J: "ɾ"
    k: "ʞ"
    K: "ʞ"
    l: "ן"
    L: "ן"
    m: "ɯ"
    M: "ɯ"
    n: "u"
    N: "u"
    o: "o"
    O: "o"
    p: "d"
    P: "d"
    q: "b"
    Q: "b"
    r: "ɹ"
    R: "ɹ"
    s: "s"
    S: "s"
    t: "ʇ"
    T: "ʇ"
    u: "n"
    U: "n"
    v: "ʌ"
    V: "ʌ"
    w: "ʍ"
    W: "ʍ"
    x: "x"
    X: "ʍ"
    y: "ʎ"
    Y: "x"
    z: "z"
    Z: "z"

  get_char: (c) ->
    if current == "Normal"
        c
    else
        unicode_fonts[current][c]

  initialize_font_selector: ->
    current_font_display = document.getElementById("current-font")
    font_selector_menu = document.getElementById("font-selector-menu")

    current_font_display.innerHTML = current + " - " + unicode_fonts[current]["sample"]

    for font of unicode_fonts
      li = document.createElement("li")
      a = document.createElement("a")
      a.innerHTML = font + " - " + unicode_fonts[font]["sample"]
      li.appendChild a
      $(li).click ((font) ->
        ->
          current = font
          current_font_display.innerHTML = current + " - " + unicode_fonts[current]["sample"] 
          return
      )(font)
      font_selector_menu.appendChild li
    return
)()