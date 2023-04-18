let currentLevel = parseInt(localStorage.currentLevel,10) || 0;
let level;
const levels = gon.challenges;

const user_progress = [];

const progress = JSON.parse(localStorage.getItem("progress")) || user_progress;

$(document).ready(function() {
    loadlevel();

	$('form').on('submit', function(e){
		e.preventDefault();
		$.post($(this).attr('action'), $(this).serialize(), function(res) {
			verifyOutput(res);
			$('#you').html(res.replaceAll("\n", "<br>"))
		});
	});

	// $(document).on('submit', 'form', function(){
	// 	$.post($(this).attr('action'), $(this).serialize(), function(res) {
	// 		$('#orders').html(res);
	// 	});
	// 	$('#order_input').val('');
	// 	return false;
	// });

    $("div#navigations img.arrow").on("click" ,function(){
        let direction;
        console.log($(this));

        if($(this).hasClass("next")) {
          direction = "next";
        }

        if(direction == "next") {
          currentLevel++;
          if(currentLevel >= levels.length) {
            currentLevel = levels.length - 1;
          }
        } else {
          currentLevel--;
          if(currentLevel < 0) {
            currentLevel = 0;
          }
        }
		loadlevel();
    });
});

function verifyOutput(output){

}

function loadlevel(){
    if(currentLevel < 0 || currentLevel >= levels) {
        currentLevel = 0;   
    }

	$('progress').attr('value', (currentLevel+1));
	$('progress').attr('max', levels.length);

    level = levels[currentLevel];

  	localStorage.setItem("currentLevel",currentLevel);

    loadchallenge();
    loadhelp();
}

function loadchallenge(){
    $('#dothis').html(level.dothis);
    $('#ruby').html(level.rubysays);
}

function loadhelp(){
	$('#title').html(level.title);
    $('#subtitle').html(level.subtitle);
    $('#method').html(level.method);
    $('#help').html(level.help);
    $('#level').html("Level " + (currentLevel+1) + " in " + (levels.length));

	let examples;
    for(let i = 0; i < level.examples.length; i++){
        examples += level.examples[i];
    }
	$('#examples').html(examples);
}