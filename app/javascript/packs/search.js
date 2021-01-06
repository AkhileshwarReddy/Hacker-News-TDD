var search_type;
var sort;
var dateRange;

function submitSearchQuery () {
    options = document.getElementById("search");
    options.submit()
}

window.addEventListener("load", () => {
    const urlParams = new URLSearchParams(window.location.search)
    const queryParam = urlParams.get('query')
    query = document.getElementById("query")
    query.value = queryParam
    query.focus()
    query.addEventListener('keyup', submitSearchQuery)
    
    search_type = document.getElementById("type")
    sort = document.getElementById("sort")
    dateRange = document.getElementById("dateRange")

    search_type.addEventListener('change', submitSearchQuery)
    sort.addEventListener('change', submitSearchQuery)
    dateRange.addEventListener('change', submitSearchQuery)
});
