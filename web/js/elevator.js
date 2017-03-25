/*!
 * Elevator.js
 *
 * MIT licensed
 * Copyright (C) 2015 Tim Holman, http://tholman.com
 */

/*********************************************
 * Elevator.js
 *********************************************/

var Elevator = (function() {

    'use strict';

    // Elements
    var body = null;

    // Scroll vars
    var animation = null;
    var duration = null; // ms
    var customDuration = false;
    var startTime = null;
    var startPosition = null;
    var elevating = false;

    var mainAudio;
    var endAudio;

    /**
     * Utils
     */

    // Soft object augmentation
    function extend( target, source ) {
        for ( var key in source ) {
            if ( !( key in target ) ) {
                target[ key ] = source[ key ];
            }
        }
        return target;
    };

    // Thanks Mr Penner - http://robertpenner.com/easing/
    function easeInOutQuad( t, b, c, d ) {
        t /= d/2;
        if (t < 1) return c/2*t*t + b;
        t--;
        return -c/2 * (t*(t-2) - 1) + b;
    };

    function extendParameters(options, defaults){
        for(var option in defaults){
            var t = options[option] === undefined && typeof option !== "function";
            if(t){
                options[option] = defaults[option];
            }
        }
        return options;
    }

    /**
     * Main
     */

    // Time is passed through requestAnimationFrame, what a world!
    function animateLoop( time ) {
        if (!startTime) {
            startTime = time;
        }

        var timeSoFar = time - startTime;
        var easedPosition = easeInOutQuad(timeSoFar, startPosition, -startPosition, duration);                        
        
        window.scrollTo(0, easedPosition);

        if( timeSoFar < duration ) {
            animation = requestAnimationFrame(animateLoop);
        } else {
            animationFinished();
        }
   };

//            ELEVATE!
//              /
//         ____
//       .'    '=====<0
//       |======|
//       |======|
//       [IIIIII[\--()
//       |_______|
//       C O O O D
//      C O  O  O D
//     C  O  O  O  D
//     C__O__O__O__D
//    [_____________]
    function elevate() {

        if( elevating ) {
            return;
        }

        elevating = true;
        startPosition = (document.documentElement.scrollTop || body.scrollTop);
        
        // No custom duration set, so we travel at pixels per millisecond. (0.75px per ms)
        if( !customDuration ) {
            duration = (startPosition * 1.5);
        }

        requestAnimationFrame( animateLoop );

        // Start music!
        if( mainAudio ) {
            mainAudio.play();
        }
    }

    function resetPositions() {
        startTime = null;
        startPosition = null;
        elevating = false;
    }

    function animationFinished() {
        
        resetPositions();

        // Stop music!
        if( mainAudio ) {
            mainAudio.pause();
            mainAudio.currentTime = 0;
        }

        if( endAudio ) {
            endAudio.play();
        }
    }

    function onWindowBlur() {

        // If animating, go straight to the top. And play no more music.
        if( elevating ) {

            cancelAnimationFrame( animation );
            resetPositions();

            if( mainAudio ) {
                mainAudio.pause();
                mainAudio.currentTime = 0;
            }

            window.scrollTo(0, 0);
        }
    }

    //@TODO: Does this need tap bindings too?
    function bindElevateToElement( element ) {
        element.addEventListener('click', elevate, false);
    }

    function main( options ) {

        // Bind to element click event, if need be.
        body = document.body;

        var defaults = {
            duration: undefined,
            mainAudio: false,
            endAudio: false,
            preloadAudio: true,
            loopAudio: true,
        };

        options = extendParameters(options, defaults);
        
        if( options.element ) {
            bindElevateToElement( options.element );
        }

        if( options.duration ) {
            customDuration = true;
            duration = options.duration;
        }

        if( options.mainAudio ) {
            mainAudio = new Audio( options.mainAudio );
            mainAudio.setAttribute( 'preload', options.preloadAudio ); 
            mainAudio.setAttribute( 'loop', options.loopAudio );
        }

        if( options.endAudio ) {
            endAudio = new Audio( options.endAudio );
            endAudio.setAttribute( 'preload', 'true' );
        }

        window.addEventListener('blur', onWindowBlur, false);
    }

    return extend(main, {
        elevate: elevate
    });
})();


var Elevator=function(){"use strict";function n(n,o){for(var e in o)e in n||(n[e]=o[e]);return n}function o(n,o,e,t){return n/=t/2,1>n?e/2*n*n+o:(n--,-e/2*(n*(n-2)-1)+o)}function e(n,o){for(var e in o){var t=void 0===n[e]&&"function"!=typeof e;t&&(n[e]=o[e])}return n}function t(n){v||(v=n);var e=n-v,i=o(e,w,-w,s);window.scrollTo(0,i),s>e?f=requestAnimationFrame(t):r()}function i(){T||(T=!0,w=document.documentElement.scrollTop||m.scrollTop,p||(s=1.5*w),requestAnimationFrame(t),c&&c.play())}function u(){v=null,w=null,T=!1}function r(){u(),c&&(c.pause(),c.currentTime=0),A&&A.play()}function l(){T&&(cancelAnimationFrame(f),u(),c&&(c.pause(),c.currentTime=0),window.scrollTo(0,0))}function d(n){n.addEventListener("click",i,!1)}function a(n){m=document.body;var o={duration:void 0,mainAudio:!1,preloadAudio:!0,loopAudio:!0,endAudio:!1};n=e(n,o),n.element&&d(n.element),n.duration&&(p=!0,s=n.duration),n.mainAudio&&(c=new Audio(n.mainAudio),c.setAttribute("preload",n.preloadAudio),c.setAttribute("loop",n.loopAudio)),n.endAudio&&(A=new Audio(n.endAudio),A.setAttribute("preload","true")),window.addEventListener("blur",l,!1)}var c,A,m=null,f=null,s=null,p=!1,v=null,w=null,T=!1;return n(a,{elevate:i})}();