  // Active Tab when clicked
  $(document).on('turbolinks:load', function() {
    $(".wrimagecard-topimage").click(function () {
        $(".wrimagecard-topimage").removeClass("active");
        $(this).addClass("active");   
    });
  });

  // Tab Sliders 
  window.onload = function () {
    // 'use strict';
    function each(e, callback) {
        var i = 0, l = e.length;
        for (; i < l; i++) {
            callback.call(e[i], i, e[i]);
        }
    }
    
    var slideDuration = 6000, // slide duration in ms
        pauseOnHover = false, // pause auto play on hover

        slideContainer = document.getElementById('slider-container'),
        slideOuter = document.getElementById('slider-outer'),
        slides = slideOuter.getElementsByClassName('slide'),
        slidesLen = slides.length,
        slidePercent = 100 / slidesLen,
        lastSlide = slidesLen - 1,
        slide0 = document.getElementsByClassName('slide0')[0],
        slide1 = document.getElementsByClassName('slide1')[0],
        slide2 = document.getElementsByClassName('slide2')[0],
        slide3 = document.getElementsByClassName('slide3')[0],
        translateLen = slidePercent * -1,
        translateBy = 0,
        threshold = 1.3,
        i = 0,
        slideInterval;

    // slides outer container width in percent
    // equal to slides number * 100
    slideOuter.style.width = slidesLen * 100 + '%';

    // slide width
    each(slides, function (i, slide) {
        slide.style.width = slidePercent + '%';
    });

    //add active class to current slide
    function activeSlide() {
        each(slides, function (index, e) {
            e.classList.remove('active');
        });
        slides[i].classList.add('active');
    }
    
    function translateSlider() {
        translateBy = i * translateLen;
        slideOuter.style.transform = 'translateX('+ translateBy +'%)';
        activeSlide();
    }
    
    function slideTo(n) {
        i = n;
        translateSlider();
    }    

    // next prev controls
    function setControls(control, d) {
        control.addEventListener('click', function () {
            window.clearInterval(slideInterval);
            slideTo(d);
        });
    }
    activeSlide();
    setControls(slide0, 0);
    setControls(slide1, 1);
    setControls(slide2, 2);
    setControls(slide3, 3);
};