/* /culture/add 에서 marker를 set 하는 js */

(function($) {
    "use strict";
    var center_default = { lat: 37.559708, lng: 126.989298 }; 
    var markers = [];
    var marker;
    
    /* 기본 marker 설정 */
    marker = addMarkers(center_default, map);
    // This event listener calls addMarker() when the map is clicked.
    /* google.maps.event.addListener(map, 'dblclick', function(event) {
      addMarker(event.latLng, map);
    });*/

    
    
    // Adds a marker to the map.
    
    
  
    // Custom options for map
    var options = {
        zoom: 11,
        center: center_default,
        disableDoubleClickZoom : false,
        minZoom: 11,
        scaleControl: false,
        streetViewControl: false,
        zoomControl: false,
        mapTypeId : 'Styled',
        disableDefaultUI: true,
        mapTypeControlOptions : {
             mapTypeIds : [ 'Styled' ]
          }
      };
    var styles = [{
        stylers : [ {
            hue : "#cccccc"
        }, {
            saturation : -100
        }]
    }, {
        featureType : "road",
        elementType : "geometry",
        stylers : [ {
            lightness : 100
        }, {
            visibility : "simplified"
        }]
    }, {
        featureType : "road",
        elementType : "labels",
        stylers : [ {
            visibility : "on"
        }]
    }, {
        featureType: "poi",
        stylers: [ {
            visibility: "off"
        }]
    }];

    var newMarker = null;
    var markers = [];

    

    var map;
    var windowHeight;
    var windowWidth;
    var contentHeight;
    var contentWidth;
    var isDevice = true;

    // calculations for elements that changes size on window resize
    var windowResizeHandler = function() {
        windowHeight = window.innerHeight;
        windowWidth = $(window).width();
        contentHeight = windowHeight - $('#header').height();
        contentWidth = $('#content').width();

        $('#leftSide').height(contentHeight);
        $('.closeLeftSide').height(contentHeight);
        $('#wrapper').height(contentHeight);
        $('#mapView').height(contentHeight);
        $('#content').height(contentHeight);
        setTimeout(function() {
            $('.commentsFormWrapper').width(contentWidth);
        }, 300);

        if (map) {
            google.maps.event.trigger(map, 'resize');
        }

        // Add custom scrollbar for left side navigation
        if(windowWidth > 767) {
            $('.bigNav').slimScroll({
                height : contentHeight - $('.leftUserWraper').height()
            });
        } else {
            $('.bigNav').slimScroll({
                height : contentHeight
            });
        }
        if($('.bigNav').parent('.slimScrollDiv').size() > 0) {
            $('.bigNav').parent().replaceWith($('.bigNav'));
            if(windowWidth > 767) {
                $('.bigNav').slimScroll({
                    height : contentHeight - $('.leftUserWraper').height()
                });
            } else {
                $('.bigNav').slimScroll({
                    height : contentHeight
                });
            }
        }
    }
    
    // function that adds the markers on map
    function addMarkers(props, map) {
      // Add the marker at the clicked location, and add the next-available label
      // from the array of alphabetical characters.
      /* markers 배열에 추가된 marker를 담음 */
      markers.push(new google.maps.Marker({
        position: props,
        map: map,
        animation: google.maps.Animation.DROP,
        icon: new google.maps.MarkerImage( 
                    "/images/marker-new.png",
                    null,
                    null,
                    null,
                    new google.maps.Size(36, 36)
                ),
        draggable : true
      }));
      /* 마지막 원소가 최종 결정된 marker */
      
      return markers[markers.length-1];
    }
    
    var repositionTooltip = function( e, ui ){
        var div = $(ui.handle).data("bs.tooltip").$tip[0];
        var pos = $.extend({}, $(ui.handle).offset(), { 
                        width: $(ui.handle).get(0).offsetWidth,
                        height: $(ui.handle).get(0).offsetHeight
                    });
        var actualWidth = div.offsetWidth;

        var tp = {left: pos.left + pos.width / 2 - actualWidth / 2}
        $(div).offset(tp);

        $(div).find(".tooltip-inner").text( ui.value );
    }

    windowResizeHandler();
    $(window).resize(function() {
        windowResizeHandler();
    });

    setTimeout(function() {
        $('body').removeClass('notransition');

        map = new google.maps.Map(document.getElementById('mapView'), options);
        var styledMapType = new google.maps.StyledMapType(styles, {
            name : 'Styled'
        });
        
        
        /* map click시에 marker 추가 */
        google.maps.event.addDomListener(map, 'click', function(event){
            /* 이전의 marker는 숨기고 */
            marker.setVisible(false);
            /* 새 marker 추가 */
            marker = addMarkers(event.latLng, map);
            // map.setCenter(event.latLng);
            
            /* input form #mapdata-lat #mapdata-lng 에 위도 경도 등록 */
            if (document.getElementById('mapdata-lat') != null && document.getElementById('mapdata-lng') != null ){
              document.getElementById('mapdata-lat').setAttribute('value', event.latLng.lat());
              document.getElementById('mapdata-lng').setAttribute('value', event.latLng.lng());
            }
            else {
              $('#input_form').append("<input id='mapdata-lat' type='hidden' name='pf_add_lat' value='"+ event.latLng.lat() +"' />");
              $('#input_form').append("<input id='mapdata-lng' type='hidden' name='pf_add_lng' value='"+ event.latLng.lng() +"' />");
            }
            
            /* 주소 등록하기 */
            $.getJSON("https://maps.googleapis.com/maps/api/geocode/json?latlng=" + event.latLng.lat() + "," + event.latLng.lng() + "&language=ko&sensor=false&key=AIzaSyCSKQCY9A2iun_28RpyYUUmVQ-o_wZzfFY", 
              function(data){
                console.log(marker.getPosition().G);
                /* 정확한 data */
                $("#address").attr("value", data.results[0].address_components[3].long_name + " " + data.results[0].address_components[2].long_name 
                + " " + data.results[0].address_components[1].long_name + " " + data.results[0].address_components[0].long_name  );
                /* ~길 까지  */
                $('#input_form').append("<input type='hidden' name='pf_address_sub' value='" + 
                    data.results[1].address_components[2].long_name + " " + data.results[1].address_components[1].long_name + 
                    " " + data.results[1].address_components[0].long_name +"' />");
              });
        });
        
        $('#place_search').change(function(){
            $.getJSON("https://maps.googleapis.com/maps/api/geocode/json?address="+$('#place_search').val(), 
                function(data, result){
                    map.setCenter(new google.maps.LatLng(data.results[0].geometry.location.lat, data.results[0].geometry.location.lng));
                    map.setZoom(14);
                });
        });
        
        map.mapTypes.set('Styled', styledMapType);
        map.setCenter(new google.maps.LatLng(37.545087, 126.987403));   // 기본 화면 center 설정
        map.setZoom(11);

    }, 300);

    if(!(('ontouchstart' in window) || window.DocumentTouch && document instanceof DocumentTouch)) {
        $('body').addClass('no-touch');
        isDevice = false;
    }

    // Header search icon transition
    $('.search input').focus(function() {
        $('.searchIcon').addClass('active');
    });
    $('.search input').blur(function() {
        $('.searchIcon').removeClass('active');
    });

    // Notifications list items pulsate animation
    $('.notifyList a').hover(
        function() {
            $(this).children('.pulse').addClass('pulsate');
        },
        function() {
            $(this).children('.pulse').removeClass('pulsate');
        }
    );

    // Exapnd left side navigation
    var navExpanded = false;
    $('.navHandler, .closeLeftSide').click(function() {
        if(!navExpanded) {
            $('.logo').addClass('expanded');
            $('#leftSide').addClass('expanded');
            if(windowWidth < 768) {
                $('.closeLeftSide').show();
            }
            $('.hasSub').addClass('hasSubActive');
            $('.leftNav').addClass('bigNav');
            if(windowWidth > 767) {
                $('.full').addClass('m-full');
            }
            windowResizeHandler();
            navExpanded = true;
        } else {
            $('.logo').removeClass('expanded');
            $('#leftSide').removeClass('expanded');
            $('.closeLeftSide').hide();
            $('.hasSub').removeClass('hasSubActive');
            $('.bigNav').slimScroll({ destroy: true });
            $('.leftNav').removeClass('bigNav');
            $('.leftNav').css('overflow', 'visible');
            $('.full').removeClass('m-full');
            navExpanded = false;
        }
    });

    // functionality for map manipulation icon on mobile devices
    $('.mapHandler').click(function() {
        if ($('#mapView').hasClass('mob-min') || 
            $('#mapView').hasClass('mob-max') || 
            $('#content').hasClass('mob-min') || 
            $('#content').hasClass('mob-max')) {
                $('#mapView').toggleClass('mob-max');
                $('#content').toggleClass('mob-min');
        } else {
            $('#mapView').toggleClass('min');
            $('#content').toggleClass('max');
        }

        setTimeout(function() {
            if (map) {
                google.maps.event.trigger(map, 'resize');
            }

            $('.commentsFormWrapper').width($('#content').width());
        }, 300);

    });

})(jQuery);