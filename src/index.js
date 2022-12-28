const express = require('express');
const axios = require('axios');

const app = express();

const serviceName = process.env.SERVICE_NAME
const loadBalancerUrl = process.env.LOADBALANCER_URL

app.get('/', async (req, res) => {
    return res.send({ error: false, v: 5 });
});

app.get(`/${serviceName}/cities`, async (req, res) => {
    // const response = await axios.get('http://' + loadBalancerUrl + '/uno/cities')
    // console.log('log:', response)
    return res.send({
        error: false,
        v: 5,
        topic: 'cities',
        form: serviceName,
        // unoResponse: JSON.stringify(response.data),
    });
});

app.get(`/${serviceName}/books`, async (req, res) => {
    // const response = await axios.get('http://' + loadBalancerUrl + '/uno/books')
    // console.log('log:', response)
    return res.send({
        error: false,
        v: 5,
        topic: 'books',
        form: serviceName,
        // unoResponse: JSON.stringify(response.data),
    });
});

app.get('/stat', async (req, res) => {
    return res.send({ error: false });
});


const server = app.listen(process.env.PORT || 4567);