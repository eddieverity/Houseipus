$(document).ready(function(){
          if ($("#buy").click(function() {
            //test fade
    
              $(".hero").css(
                {'background': 'url("/assets/hero.jpg")',
                'background-repeat': 'no-repeat',
                'background-position': 'center',
                'background-size': 'cover' 
                })
           
      
            //testfade
          }));
          
          if ($("#rent").click(function() {
      
              $(".hero").css(
                  {'background': 'linear-gradient(rgba(0, 0, 0, 0.45),rgba(0, 0, 0, 0.45)), url("/assets/beachhome.jpg")',
                  'background-repeat': 'no-repeat',
                  'background-position': 'center',
                  'background-size': 'cover',
                });
           
          }));

          if ($("#sell").click(function() {

              $(".hero").css(
                  {'background': 'linear-gradient(rgba(0, 0, 0, 0.45),rgba(0, 0, 0, 0.45)), url("/assets/pymhouse.png")',
                  'background-repeat': 'no-repeat',
                  'background-position': 'center',
                  'background-size': 'cover' 
                });
     
          }));
    });