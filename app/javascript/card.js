// app/javascript/card.js
const pay = () => {
  const form = document.getElementById("charge-form");
  if (!form) return;

  if (form.dataset.payjpInitialized === "true") return;
  form.dataset.payjpInitialized = "true";

  const publicKey = document
    .querySelector('meta[name="payjp-public-key"]')
    .getAttribute("content");

  const payjp = Payjp(publicKey);

  const elements = payjp.elements();

  const numberElement = elements.create("cardNumber");
  const expiryElement = elements.create("cardExpiry");
  const cvcElement = elements.create("cardCvc");

  numberElement.mount("#number-form");
  expiryElement.mount("#expiry-form");
  cvcElement.mount("#cvc-form");

  form.addEventListener("submit", (e) => {
    e.preventDefault();

    payjp.createToken(numberElement).then((response) => {
      if (response.error) {

      } else {
        const token = response.id;

        // ✅ このフォーム内だけを対象にして増殖防止
        const existingToken = form.querySelector('input[name="token"]');
        if (existingToken) existingToken.remove();

        const tokenObj = `<input value="${token}" type="hidden" name="token">`;
        form.insertAdjacentHTML("beforeend", tokenObj);

        form.submit();

      }
    });
  });
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);
