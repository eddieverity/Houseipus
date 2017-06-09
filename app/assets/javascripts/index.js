$(document).ready(function(){
          if ($("#buy").click(function() {
            //test fade
            $(".hero").fadeOut(200, function(){
              $(".hero").css(
                {'background': 'url("/assets/hero.jpg")',
                'background-repeat': 'no-repeat',
                'background-position': 'center',
                'background-size': 'cover' 
                })
                $(".hero").fadeIn(200)
            })
            //testfade
          }));
          
          if ($("#rent").click(function() {
            $(".hero").fadeOut(200, function(){
              $(".hero").css(
                  {'background': 'linear-gradient(rgba(0, 0, 0, 0.45),rgba(0, 0, 0, 0.45)), url("/assets/beachhome.jpg")',
                  'background-repeat': 'no-repeat',
                  'background-position': 'center',
                  'background-size': 'cover',
                });
              $(".hero").fadeIn(200)
            })
          }));

          if ($("#sell").click(function() {
            $(".hero").fadeOut(200, function(){
              $(".hero").css(
                  {'background': 'linear-gradient(rgba(0, 0, 0, 0.45),rgba(0, 0, 0, 0.45)), url("/assets/pymhouse.png")',
                  'background-repeat': 'no-repeat',
                  'background-position': 'center',
                  'background-size': 'cover' 
                });
              $(".hero").fadeIn(200)
            }) 
          }));
    });