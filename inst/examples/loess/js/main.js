var updateSmoother = function() {
    var span = document.getElementById("spanalpha").value;
    var xhr = new XMLHttpRequest();

    // Set label to be new value of span
    document.querySelector("label").innerHTML = "Span: " + span;
    
    var changeSmoother = function() {
        if (xhr.readyState !== xhr.DONE)
            return;
        var obj = xhr.responseXML;
        // Grabbing the smoother group node
        var smoothLine = document.querySelector('[id^="smoother"]');
        // Parsing the SVG output from the server
        var smoother = obj.documentElement.firstChild;// new DOMParser()
//            .parseFromString(obj, "image/svg+xml")
//            .documentElement
//            .firstChild;

        // If we have a smoother, update it to a new position
        if (smoothLine) {
            // Get the <polyline> from the <g>
            smoothLine = smoothLine.firstChild;
            // Get the new points attr from the <polyline> el
            var newpoints = smoother.firstChild.getAttribute("points");
            // Update the points attribute over 1s
            d3.select(smoothLine)
                .transition()
                .duration(1000)
                .attr("points", newpoints);
        } else {
            // Find the "panel" viewport, this is usually an SVG group
            // with a name like "panel.3-4-3-4" so search for something
            // starting with "panel"
            var panelvp = d3.select('[id^="panel"]').node();
            // If we can find such a viewport, append the smoother
            if (panelvp)
                panelvp.appendChild(smoother);
        }
    };
    xhr.onreadystatechange = changeSmoother;
    xhr.open("GET", "/custom/loess/brew/loessLine?span=" + span);
    xhr.send();
}

d3.select("#spanalpha")
    .on("mouseup", updateSmoother);
