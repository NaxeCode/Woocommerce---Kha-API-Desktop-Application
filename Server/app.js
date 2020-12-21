const WooCommerceRestApi = require("@woocommerce/woocommerce-rest-api").default;
// import WooCommerceRestApi from "@woocommerce/woocommerce-rest-api"; // Supports ESM

const WooCommerce = new WooCommerceRestApi({
  url: 'https://attackdogattire.com',
  consumerKey: 'ck_f073a437308d3aaff59d9e5c6a8ca7d80c0d9e09',
  consumerSecret: 'cs_efca1f85a8dfb9d5d376bc7474999348bcf053d0',
  version: 'wc/v3'
});

WooCommerce.get("orders", {
  per_page: 1, // 20 products per page
})
  .then((response) => {
    // Successful request
    console.log("Response Status:", response.status);
    console.log("Response Headers:", response.headers);
    console.log("Response Data:", response.data);
    console.log("Total of pages:", response.headers['x-wp-totalpages']);
    console.log("Total of items:", response.headers['x-wp-total']);
  })
  .catch((error) => {
    // Invalid request, for 4xx and 5xx statuses
    console.log("Response Status:", error.response.status);
    console.log("Response Headers:", error.response.headers);
    console.log("Response Data:", error.response.data);
  })
  .finally(() => {
    // Always executed.
  });

/*
const http = require('https');

const hostname = '127.0.0.1';
const port = 3000;

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end("Successfully connected to Naxe's server");
});

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});
//https://attackdogattire.com/wp-json/wc/v3/orders
*/