$(document).ready(function(){

    $.fn.preload = function() {
    this.each(function(){
        $('<img/>')[0].src = this;
        });
    }   


    $([
    'assets/hero.jpg',
    'assets/beachhome.jpg',
    'assets/pymhouse.png'
    ]).preload();

          if ($("#buy").click(function() {
              $(".hero").css(
                {'background': 'linear-gradient(rgba(0, 0, 0, 0.45),rgba(0, 0, 0, 0.45)), url("/assets/hero.jpg")',
                'background-repeat': 'no-repeat',
                'background-position': 'center',
                'background-size': 'cover',
                });
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
                  'background-size': 'cover',
                });
          }));
    });