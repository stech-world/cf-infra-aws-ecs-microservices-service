const express = require('express');
const axios = require('axios');

const app = express();

const serviceName = process.env.SERVICE_NAME
const loadBalancerUrl = process.env.LOADBALANCER_URL

app.get('/', async (req, res) => {
    return res.send({ error: false, v: 5 });
});

app.get(`/${serviceName}/cities`, async (req, res) => {
    // const response = await axios.get('http://' + loadBalancerUrl + '/due/cities')
    // console.log('log:', response)
    return res.send({
        error: false,
        v: 5,
        topic: 'cities',
        form: serviceName,
        // dueResponse: JSON.stringify(response.data),
    });
});

app.get(`/${serviceName}/books`, async (req, res) => {
    // const response = await axios.get('http://' + loadBalancerUrl + '/due/books')
    // console.log('log:', response)
    return res.send({
        error: false,
        v: 5,
        topic: 'books',
        form: serviceName,
        // dueResponse: JSON.stringify(response.data),
    });
});

app.get('/stat', async (req, res) => {
    return res.send({ error: false });
});


const server = app.listen(process.env.PORT || 4567);

if (process.env.NODE_ENV === 'production') {
    process.on('SIGINT', () => {
        server.close(() => {
            process.exit(0);
        });
    });
}
