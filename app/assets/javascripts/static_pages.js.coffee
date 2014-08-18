# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
    if $("body").hasClass("static_pages_quote_builder")
        Unicode.initialize_font_selector()
        builder = document.getElementById("builder")
        $(".eu").click ->
            builder.value += this.innerHTML
            return
        builder.onkeypress = (key) ->
            alpha = String.fromCharCode(key.charCode)
            if !/[^a-zA-Z]/.test(alpha)
                builder.value += Unicode.get_char(alpha)
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