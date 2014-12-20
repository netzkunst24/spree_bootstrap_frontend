$ ->
  $('[data-toggle="popover"]').popover
    html: true

  selected_taxon = $("#search-select option:selected")
  $("#search-bar button.dropdown-toggle").html selected_taxon.text() + " <span class='caret'></span>"
  $("#search-bar form").attr('action', '/t/kategorie/' + selected_taxon.text().toLowerCase()) if selected_taxon.val()
  $("#search-bar .dropdown-menu").on "click", "li a", (event) ->
    event.preventDefault()
    $this = $(this)
    $this.parents("ul").find("a").removeClass "active"
    $this.addClass "active"
    $this.parents(".input-group-btn").find("button").html $this.text() + " <span class='caret'></span>"
    $("#search-select").val $this.data("value")
    keywords = $('.typeahead').typeahead('val');
    $(".typeahead").typeahead('val', '').focus().typeahead('val', keywords).focus() if keywords
    if $("#search-select option:selected").val()
      $this.parents('form').attr('action', '/t/kategorie/' + $this.text().toLowerCase())
    else
      $this.parents('form').attr('action', '/products')


  $("#search-bar").on "submit", "form", ->
      false  if $.trim($("#keywords").val()) is ""


  # TODO check if product is package based
  # TODO check on pageload
  # TODO REFACTOR
  currency = "€"
  $("body").on "keyup mouseup", ".add-to-cart input.ve", ->
    unit = $(".add-to-cart input.ve").next().data('unit')
    unit_pl = if unit.slice(-1) == 'e' then unit else unit + 'e'
    amountField = $ this
    qmField = $ ".add-to-cart input.qm"
    amount = Math.ceil(amountField.val().replace(",", "."))
    return false if isNaN(amount)
    priceTag = $ "#add-to-cart-button .btn-price"
    paket = if amount > 1 then unit_pl else unit
    ceiled = if amount != parseFloat(amountField.val()) then "(" + amount + ") " else ""
    amountField.next().text(ceiled + paket) if paket
    qmField.val(("" + (qmField.attr("min") * amount).toFixed(2)).replace(".", ",")) if qmField
    priceTag.text((amount * $(".price.selling").attr("data-price-amount")).toFixed(2).replace(".", ",") + " " + currency)

  # TODO REFACTOR
  $("body").on "keyup mouseup", ".add-to-cart input.qm", ->
    unit = $(".add-to-cart input.ve").next().data('unit')
    unit_pl = if unit.slice(-1) == 'e' then unit else unit + 'e'
    amountField = $(".add-to-cart input.ve")
    qmField = $ this
    priceTag = $ "#add-to-cart-button .btn-price"
    qm = parseFloat(qmField.val().replace(",", "."))
    return false if isNaN(qm)
    amount = Math.ceil(qm / qmField.attr("min"))
    amountField.val("" + amount)
    paket = if amount > 1 then unit_pl else unit
    amountField.next().text(paket) if paket
    priceTag.text((amount * $(".price.selling").attr("data-price-amount")).toFixed(2).replace(".", ",") + " " + currency)
    realQm = parseFloat((qmField.attr("min") * amount).toFixed(2))
    if qm != realQm then qmField.next().text( "(" + (realQm + "").replace(".", ",") + ") m²") else qmField.next().text("m²")
    #$(".add-to-cart input").first().trigger("keyup")


  # TODO move to carousel extension
  $frame = $ "#ws-accessories .frame"
  $wrap = $frame.parent()

  $frame.sly
    horizontal: 1
    itemNav: 'basic'
    smart: 1
    activateOn: 'click'
    mouseDragging: 1
    touchDragging: 1
    releaseSwing: 1
    elasticBounds: 1
    easing: 'easeOutExpo'
    dragHandle: 1
    dynamicHandle: 1
    clickBar: 1
    scrollBy: 1
    prevPage:  $wrap.find('.prev')
    nextPage:  $wrap.find('.next')