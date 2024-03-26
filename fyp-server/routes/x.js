const client = require("twilio")(
  "YOUR_TWILIO_ACCOUNT_SID",
  "YOUR_TWILIO_AUTH_TOKEN"
);

try {
  client.messages
    .create({
      from: "+12673290739",
      to: "011923330387860",
      body: "You just sent an SMS from Node.js using Twilio!",
    })
    .then((message) => console.log(message.sid));
} catch (e) {
  console.log(e);
}
