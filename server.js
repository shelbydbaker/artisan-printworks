const express = require("express");

const app = express();
const PORT = process.env.PORT || 3000;

app.get("/", (req, res) => {
    res.send("Artisan Printworks API is running!");
});

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});

