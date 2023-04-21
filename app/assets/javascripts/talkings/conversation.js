let currentChallenge = parseInt(localStorage.currentChallenge,10) || 0; // Gets the currentChallenge data from the localStorage if null then it's set to 0
let challenge; 
const challenges = gon.challenges; // Gets all the Challenges passed from the controller to the view file

let progress = localStorage.getItem("progress");
if (progress && progress !== "") {
	progress = JSON.parse(progress);
} else {
	progress = [];
}

$(document).ready(function() {
	loadchallenge();
	loadchallengeslist();
	
	// IDE
	let editor = ace.edit("editor");
	editor.setTheme("ace/theme/vibrant_ink");
	editor.session.setMode("ace/mode/ruby");

	editor.container.addEventListener("keypress", function(event) {
		if (event.shiftKey && event.keyCode === 13) {
			event.preventDefault();

			editor.insert("\n");
		} 
		else if(event.keyCode === 13) {
			event.preventDefault();

			$('form').submit();
		}

	});

	// Realtime update of the response or the output of the users answer
	$('form').on('submit', function(e){
		e.preventDefault();
		let answer = editor.getValue();
		let modified_answer = encodeURIComponent(answer);

		$.post($(this).attr('action'), $(this).serialize() + "&answer=" + modified_answer + "&challenge=" + currentChallenge, function(res) {
			let correct = verifyOutput(res);
			$('#you').removeAttr('class');
			
			if(correct){	
				$('#level').append("<img id='rubybadge' src = '" + rubybadge + "' alt = 'alt'>");
				$('#you').addClass("correct");
				$('#rubygem').attr('src', rubycorrect);
				$('#ruby').html("You got it right!");
				$('#you').html("Lezgooooo!");

				setTimeout(function() {
					editor.setValue('');
					resetresponse();
					updatechallengeslist();
					loadchallenge();
				}, 2500);
			} else{
				if(res === 'Error'){
					$('#you').addClass("wrong");
					$('#ruby').html("Not even close.");
					$('#rubygem').attr('src', rubywrong);
					$('#you').html("I'm sorry, let me try again.");

					setTimeout(function() {
						$('#ruby').html(challenge.rubysays);
						$('#rubygem').attr('src', rubyasks);
						$('#you').html(". . .");
						$('#you').removeClass("wrong");
					}, 2500);
				} else{
					$('#you').addClass("wrong");
					$('#ruby').html("Come on you can do it!");
					$('#rubygem').attr('src', rubyyoucandoit);
					$('#you').html("Okay, Let me try again.");

					setTimeout(function() {
						$('#ruby').html(challenge.rubysays);
						$('#rubygem').attr('src', rubyasks);
						$('#you').html(". . .");
					}, 2500);
				}
			}
		});
	});

	// Shows all the challenges by clicking the dropdown
	$('.dropdown-menu').on('click', function(){
		showchallenges();
	});

	$('div#challenges ol li').on('click', function(){
		let listID = $(this).attr('id');
		currentChallenge = parseInt(listID.match(/\d+/)[0]);
		
		editor.setValue('');
		resetresponse();
		loadchallenge();
		showchallengedesc();
	});

	$('button#reset').on('click', function(){
		editor.setValue('');

		resetGame();
		loadchallenge();
		showchallengedesc();
		updatechallengeslist();	
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
	let result = false;
	for(let expect_index = 0; expect_index < challenge.expected_output.length; expect_index++){
		if(output === challenge.expected_output[expect_index]){
			let existing = false;
			for(let i = 0; i < progress.length; i++){
				if(progress[i] === currentChallenge){
					existing = true;
				}
			}
	
			if(existing == false){
				progress.push(currentChallenge);
			}
			
			localStorage.setItem("progress", JSON.stringify(progress));
			
			currentChallenge++;
			if(currentChallenge >= challenges.length) {
				currentChallenge = challenges.length - 1;
			}
			result = true;
		}
	}
	return result;
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
				list += "<p class='chapter'>" + challenges[i].title + "</p>"; 
			}
		} else{
			list += "<p class='chapter'>" + challenges[i].title + "</p>"; 
		}
		
		list += "<li id='c" + i + "'>" + challenges[i].topic;
		let iscomplete = ischallengecomplete(i);
		if(iscomplete == true){
			list += "<img class='rubybadge' src = '" + rubybadge + "' alt = 'alt'>"
		}
		list += "</li>";
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
	let rubyprovides = challenge.rubyprovide || '';

	let editor = ace.edit("editor");	
	editor.session.setValue(rubyprovides);  
	
	$('#dothis').html(challenge.dothis);
    $('#ruby').html(challenge.rubysays);
    $('#you').html('. . .');
    $('#rubygem').attr('src', rubyasks);
}

function loaddescription(){
	let method = challenge.method || '';
	let methoddesc = challenge.methoddesc || '';

	if(method == ''){
		$('#method').hide();
		$('#methoddesc').hide();
	} else{
		$('#method').show();
		$('#methoddesc').show();
	}

	$('#topic').html(challenge.topic);
	$('#topicdesc').html(challenge.topicdesc);
	$('#title').html(challenge.title);
    $('#subtitle').html(challenge.subtitle);
    $('#method').html(method);
    $('#methoddesc').html(methoddesc);

	$('#level').html('Challenge ' + (currentChallenge+1) + " of " + (challenges.length));
	
	let iscomplete = ischallengecomplete(currentChallenge);
	if(iscomplete){
		$('#level').append("<img id='rubybadge' src = '" + rubybadge + "' alt = 'alt'>");
	}

	let examples = '';
    for(let i = 0; i < challenge.examples.length; i++){
        examples += challenge.examples[i];
    }
	$('#examples').html(examples);
}

function resetresponse(){
	$('#you').html('');	
}

function ischallengecomplete(thechallenge){
	let complete = false;
	for(let i = 0; i < progress.length; i++){
		if(thechallenge === progress[i]){
			complete = true;
		}
	}

	return complete;
}

function updatechallengeslist(){
	let allchallenges = document.querySelectorAll('ol li');
	for(let challengeID = 0; challengeID < allchallenges.length; challengeID++){
		let result = ischallengecomplete(challengeID);
		if(result == true){
			$('div#challenges_list ol li#c' + (challengeID)).append("<img class='rubybadge' src = '" + rubybadge + "' alt = 'rubyimage'>");
		} else{
			$('div#challenges_list ol li#c' + (challengeID) + ' img').remove();
		}
	}
}

function resetGame(){
	currentChallenge = 0;
	progress = [];

	localStorage.setItem("currentChallenge",currentChallenge);
	localStorage.setItem("progress", JSON.stringify(progress));
}