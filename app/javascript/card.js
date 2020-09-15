const pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);　// PAY.JPテスト公開鍵
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();
 
    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);
 
    const card = {
      number: formData.get("purchase[number]"),
      cvc: formData.get("purchase[cvc]"),
      exp_month: formData.get("purchase[exp_month]"),
      exp_year: `20${formData.get("purchase[exp_year]")}`,
    };
    console.log(card)
    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        console.log(response.id)
        // const renderDom = document.getElementById("charge-form");
        // トークンの情報を含んでいる
        const tokenObj = `<input value=${token} type="hidden" name='token'>`;
        form.insertAdjacentHTML("beforeend", tokenObj);
      
      document.getElementById("number").removeAttribute("name");
      document.getElementById("cvc").removeAttribute("name");
      document.getElementById("exp_month").removeAttribute("name");
      document.getElementById("exp_year").removeAttribute("name");
 
      document.getElementById("charge-form").submit();
      document.getElementById("charge-form").reset();
      }else{
        console.log(response.error.message);
        submit_btn = document.getElementsByClassName("decide-btn")[0];
        submit_btn.disabled = false;
      }
    });
  });
 };
 
 window.addEventListener("load", pay);