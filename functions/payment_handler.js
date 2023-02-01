const AWS = require('aws-sdk');
const moncash = require('nodejs-moncash-sdk');
const { v4: uuidv4 } = require('uuid');

const CLIENT_ID = process.env['CLIENT_ID']
const CLIENT_SECRET = process.env['SECRET_ID']

const response = (statusCode, message) => {
    return {
      headers: {"Access-Control-Allow-Origin": "*", 'Access-Control-Allow-Credentials': true},
      statusCode: statusCode,
      body: JSON.stringify(message)
    };
}


moncash.configure({
    'mode': 'sandbox', //sandbox or live
    'client_id': CLIENT_ID,
    'client_secret': CLIENT_SECRET
    });
 module.exports.handler = (event, context, callback) => {
    const body = JSON.parse(event.body);

    const create_payment_json = {
        "amount": body.amount,
        "orderId": uuidv4().toString() 
    };

    const payment_creator = moncash.payment;
    payment_creator.create(create_payment_json, function (error, payment) {
        if (error) {
            console.log(error)
            return callback(null, response(500, {messageType: "error", err: error}));
        } else {
            const redirectionUrl = payment_creator.redirect_uri(payment);
            return callback(null, response(200, {messageType: "success", url: redirectionUrl}));
        }
    });
}

