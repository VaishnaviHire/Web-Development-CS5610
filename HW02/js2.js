
(function() {
    function numAlert(){
	window.alert(document.getElementById("hd1").innerHTML);
    }
    var btn1=document.getElementById("bt1");
    btn1.addEventListener("click", numAlert);
    
    function increment(){
	document.getElementById("hd1").innerHTML ++;
    }

    var btn2 = document.getElementById("bt2");
    btn2.addEventListener("click", increment);

    function addpara(){
	var newpara = document.createElement('p');
	newpara.textContent = document.getElementById("hd1").innerHTML;
	document.getElementById("p1").appendChild(newpara);
    }

    var btn3 = document.getElementById("bt3");
    btn3.addEventListener("click",addpara);

   
})();
