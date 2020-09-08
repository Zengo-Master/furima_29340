window.addEventListener('load', function(){

  const price = document.getElementById("price")
  const tax = document.getElementById("tax")
  const profit = document.getElementById("profit")

    price.addEventListener('keyup', function(){
      var tax_value = Math.floor(price.value / 10);
      var profit_value = (price.value - tax_value); 
      tax.innerHTML = tax_value;
      profit.innerHTML = profit_value;
    })

  })