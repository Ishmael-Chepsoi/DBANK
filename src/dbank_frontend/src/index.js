import { dbank_backend } from "../../declarations/dbank_backend";

window.addEventListener("load", async function () {
  // console.log("finish loading");
  update();
});

document.querySelector("form").addEventListener("submit", async function (event) {
  event.preventDefault();
  // console.log("Submitted.");

  const button = event.target.querySelector("#submit-btn");

  const inputAmount = parseFloat(document.getElementById("input-amount").value);
  const outputAmount = parseFloat(document.getElementById("withdrawal-amount").value);

  button.setAttribute("disabled", true);
  //validate the value
  if (document.getElementById("input-amount").value.length != 0) {
    await dbank_backend.topUp(inputAmount);
  }

  if (document.getElementById("withdrawal-amount").value.length != 0) {
    await dbank_backend.withdrawl(outputAmount)
  }

  //compounding
  await dbank_backend.compound();

  update();

  document.getElementById("withdrawal-amount").value = "";
  document.getElementById("input-amount").value = "";
  button.removeAttribute("disabled");

});
async function update() {
  const currentAmount = await dbank_backend.checkBallance();
  document.getElementById("value").innerText = Math.round(currentAmount * 100) / 100;
}



