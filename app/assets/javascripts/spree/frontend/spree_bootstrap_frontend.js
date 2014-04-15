// Placeholder for dummy application
$(function () {
    $("#search-bar button.dropdown-toggle").html($("#search-select option:selected").text() + " <span class='caret'></span>");

    $("#search-bar .dropdown-menu").on("click", "li a", function(event){
        event.preventDefault();
        $this = $(this);
        $this.parents("ul").find("a").removeClass("active")
        $this.addClass("active");
        $this.parents(".input-group-btn").find("button").html($this.text() + " <span class='caret'></span>");
        $("#search-select").val($this.data("value"));
    })

    $("#search-bar").on("submit", "form", function() {
        if ($.trim($("#keywords").val()) === "") return false;
    });
})