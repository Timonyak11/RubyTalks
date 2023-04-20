let currentChallenge = parseInt(localStorage.currentChallenge,10) || 0; 
let challenge;
const challenges = gon.challenges;

const user_progress = [];

const progress = JSON.parse(localStorage.getItem("progress")) || user_progress;

$(document).ready(function() {
	loadchallenge();
	loadchallengeslist();
	
	// IDE
	let editor = ace.edit("editor");
	editor.setTheme("ace/theme/vibrant_ink");
	editor.session.setMode("ace/mode/ruby");

	$('div#challenges ol li').on('click', function(){
		currentChallenge = parseInt($(this).attr('id'));

		editor.setValue('');
		resetresponse();
		loadchallenge();
		showchallengedesc();
	});

	// Realtime update of the response or the output of the users answer
	$('form').on('submit', function(e){
		e.preventDefault();
		let answer = editor.getValue();
		
		$.post($(this).attr('action'), $(this).serialize() + "&answer=" + answer, function(res) {
			verifyOutput(res);
			$('#you').html(res.replaceAll("\n", "<br>"))
		});
	});

	// Shows all the challenges by clicking the dropdown
	$('.dropdown-menu').on('click', function(){
		showchallenges();
	});

	// Closes the view to all challenges then proceeds to show the description of a challenge
	$('.exit').on('click', function(){
		showchallengedesc();
	});

	// Navigation through the challenges
    $("div#navigations img.arrow").on("click" ,function(){
        let direction;

        if($(this).hasClass("next")) {
          	direction = "next";
        }

        if(direction == "next") {
			currentChallenge++;
			if(currentChallenge >= challenges.length) {
				currentChallenge = challenges.length - 1;
			}
        } else {
			currentChallenge--;
			if(currentChallenge < 0) {
				currentChallenge = 0;
			}
        }
		editor.setValue('');
		resetresponse();
		loadchallenge();
    });
});

function verifyOutput(output){
	console.log(output === challenge.expected_output);
}

function showchallenges(){
	$('div#challenge_desc').slideUp();
	$('div#challenges_list').delay(400).slideDown();
}

function showchallengedesc(){
	$('div#challenges_list').slideUp();
	$('div#challenge_desc').delay(400).slideDown();
}


function loadchallengeslist(){
	let chapter;
	let list = "<ol>";
	for(let i = 0; i < challenges.length; i++){
		if(i > 0){
			chapter = challenges[i-1].title;
			if(chapter != challenges[i].title){
				list += "<p>" + challenges[i].title + "</p>"; 
			}
		} else{
			list += "<p id='chapter'>" + challenges[i].title + "</p>"; 
		}
		
		list += "<li id='" + i + "'>" + challenges[i].method + "</li>";
	}
	list += "</ol>";
	$('div#challenges').html(list);
}

function loadchallenge(){
    if(currentChallenge < 0 || currentChallenge >= challenges) {
        currentChallenge = 0;   
    }

	$('progress').attr('value', (currentChallenge+1));
	$('progress').attr('max', challenges.length);

    challenge = challenges[currentChallenge];

  	localStorage.setItem("currentChallenge",currentChallenge);

    loadconvofield();
    loaddescription();
}

function loadconvofield(){
    $('#dothis').html(challenge.dothis);
    $('#ruby').html(challenge.rubysays);
}

function loaddescription(){
	$('#title').html(challenge.title);
    $('#subtitle').html(challenge.subtitle);
    $('#method').html(challenge.method);
    $('#help').html(challenge.help);
    $('#level').html("Challenge " + (currentChallenge+1) + " of " + (challenges.length));

	let examples;
    for(let i = 0; i < challenge.examples.length; i++){
        examples += challenge.examples[i];
    }
	$('#examples').html(examples);
}

function resetresponse(){
	$('#you').html('');	
}