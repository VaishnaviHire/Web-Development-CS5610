
(function(){
    function showPara(id){
	if(id == "link1"){
	    document.getElementById("p1").innerHTML = document.getElementById("p2").innerHTML;
	}
	
	if(id == "link2"){
	    document.getElementById("p1").innerHTML = document.getElementById("p3").innerHTML;
	}
	
	if(id == "link3"){
	    document.getElementById("p1").innerHTML ="this is the third thing";
	}
    }
    

    var l1 = document.getElementById("link1");
    l1.addEventListener("click",function (){ showPara("link1");});
		    
    var l2 = document.getElementById("link2");
    l2.addEventListener("click",function(){showPara("link2");});

    var l3 = document.getElementById("link3");
    l3.addEventListener("click",function(){showPara("link3");});

    document.getElementById("body").onload = function(){showPara("link1");};
})();

