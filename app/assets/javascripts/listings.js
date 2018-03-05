

document.addEventListener("turbolinks:load", function() {

    let searchTitle = document.getElementById("search-title");
    var searchCity = document.getElementById("search-city")


    if (searchTitle) {
    searchTitle.addEventListener("keyup", function(event){
        autocomplete(event, "title-list", "title")
    })
    }

    if (searchCity){
    searchCity.addEventListener("keyup", function(event){
        autocomplete(event, "city-list", "city")
    })
    }

    window.globalXHR = new XMLHttpRequest()

    function autocomplete(event, type_list, type) {
    //retrieve input
    var input = event.target
    // console.log(event)
    // console.log(input.value)

    //get datalist element for results
    var list = document.getElementById(type_list)
    // var citylist = document.getElementById("city-list")

    //set minimum num of chars
    var min_chars = 0

    if (input.value.length > min_chars) {
        //abort pending requests
        //ensure that our XHR object is not working on any pending request before we tell it to do new work
        window.globalXHR.abort()

        // Callback to be applied once the XMLHttpRequest() internal state has been changed after
        // sending a request
        // We check to see whether the request is done and that the return status of the request is ok
        window.globalXHR.onreadystatechange = function(){
        if (this.readyState == 4 && this.status == 200) {
            console.log(this)
            //convert json response to an object
            var response = JSON.parse(this.responseText)

            //clear previous results
            list.innerHTML = ""
            // citylist.innerHTML = ""

            // alert(response);

            response.forEach(function(element){
            //create new option element
            var option = document.createElement("option")
            option.value = element

            //append option to list
            list.appendChild(option)
            //   citylist.appendChild(option)
            })
        }
        }

        // authentication is required whenever our client wishes to make a request to our server
        // this is to prevent csrf attacks on our servers
        // more info can be found at the link below
        // https://www.checkmarx.com/2016/01/22/ultimate-guide-understanding-preventing-csrf/
        var auth_token = document.querySelector("[name='csrf-token']").content
        window.globalXHR.open("POST", "/search_" + type + "?" + type + "=" + input.value, true)
        //allow js to make request to rails server
        window.globalXHR.setRequestHeader("X-CSRF-TOKEN", auth_token)
        window.globalXHR.send()
    }
    }


    // // for fade in and out
    // $(document).ready(function() {
        
    //     // var listing = $(".listing");
    //     // var index = 0;
    //     var visibleIndex = 0;

    //     // function next(listing_photos) {
    //     //     var i=0;    
            
    //     //     while (i<listing_photos.length){                
            
    //     //         i++;

    //     //         // fade out the currently visible item
    //     //         listing_photos.eq(visibleIndex).fadeTo(1000, 0, function () {
    //     //             // at the same time, fade in the next item
    //     //             console.log(visibleIndex)
    //     //             visibleIndex = ++visibleIndex % listing_photos.length;
    //     //             console.log(visibleIndex)
    //     //             console.log(listing_photos)
    //     //             // debugger
    //     //             listing_photos.eq(visibleIndex).fadeTo(1000, 1, function () {
    //     //                 // setTimeout(next(listing_photos), 1000);
    //     //             }); 
    //     //         });
    //     //     };            
    //     // };
        
        
    //     $(".listing").each(function() {
            
    //         var listing_photos = $(this).find(".map").find(".map-photos");
    //         numberOfPhotos = parseInt($(this).find(".map").data("count"));
    
    //         // for (i = 0; i < numberOfPhotos; i++){
    //             listing_photos.css("opacity", 0);
    //             listing_photos.eq(0).css("opacity", 1);

    //             var i=0;    
            
    //             while (i<listing_photos.length){                
                
    //                 i++;

    //                 // fade out the currently visible item
    //                 listing_photos.eq(visibleIndex).fadeTo(1000, 0, function () {
    //                     // at the same time, fade in the next item
    //                     console.log(visibleIndex)
    //                     visibleIndex = ++visibleIndex % listing_photos.length;
    //                     console.log(visibleIndex)
    //                     console.log(listing_photos)
    //                     // debugger
    //                     listing_photos.eq(visibleIndex).fadeTo(1000, 1, function () {
    //                         // setTimeout(next(listing_photos), 1000);
    //                     }); 
    //                 });
    //             };
                
    //         // };
    //     });
        
    //     // var listing_photos = $(".map");
    //     // debugger;


    // });

});