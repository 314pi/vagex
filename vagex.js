var steps=[];
var testindex = 0;
var loadInProgress = false;//This is set to true when a page is still loading

/*********SETTINGS*********************/
var webPage = require('webpage');
var page = webPage.create();
page.settings.userAgent = 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36';
page.settings.javascriptEnabled = true;
page.settings.loadImages = false;//Script is much faster with this field set to false
phantom.cookiesEnabled = true;
phantom.javascriptEnabled = true;
/*********SETTINGS END*****************/
console.log('All settings loaded, start with execution');
page.onConsoleMessage = function(msg) {
    console.log(msg);
};
/**********DEFINE STEPS THAT FANTOM SHOULD DO***********************/
// --cookies-file=cookies.txt
steps = [
    function(){
        console.log('Open Vagex Member page');
        page.open("http://vagex.com/members/index.php", function(status){
		});
    },
    function(){
		page.evaluate(function(){
			if(!document.getElementById("plasmid")){
				document.querySelector("input[name='email']").value="458167";
				document.querySelector("input[name='passwd']").value="1qaz2wsx";
				document.querySelector("input[name='save']").checked = true ;
				document.getElementsByName("submit")[0].click();
			};
		});
    },
    function(){
        console.log('Open Vagex Viewer page');
        page.open("http://vagex.com/members/viewers.php", function(status){
		});
    },
    function(){
		page.evaluate(function(){
			console.log(document.querySelectorAll('tbody,tr')[0].innerText);
		});
    }
];
/**********END STEPS THAT FANTOM SHOULD DO***********************/

//Execute steps one by one
interval = setInterval(executeRequestsStepByStep,50);

function executeRequestsStepByStep(){
    if (loadInProgress == false && typeof steps[testindex] == "function") {
        //console.log("step " + (testindex + 1));
        steps[testindex]();
        testindex++;
    }
    if (typeof steps[testindex] != "function") {
        console.log("complete!");
        phantom.exit();
    }
}

/**
 * These listeners are very important in order to phantom work properly. Using these listeners, we control loadInProgress marker which controls, weather a page is fully loaded.
 * Without this, we will get content of the page, even a page is not fully loaded.
 */
page.onLoadStarted = function() {
    loadInProgress = true;
    console.log('Loading started');
};
page.onLoadFinished = function() {
    loadInProgress = false;
    console.log('Loading finished');
};
page.onConsoleMessage = function(msg) {
    console.log(msg);
};