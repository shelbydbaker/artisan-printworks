require("dotenv").config(); // Load environment variables
const { Pool } = require("pg"); // Import PostgreSQL library

// Connect to the database
const pool = new Pool({
    connectionString: process.env.DATABASE_URL,
    ssl: { rejectUnauthorized: false } // Required for Supabase
});

// Test the database connection
pool.connect()
    .then(() => console.log("✅ Connected to Supabase PostgreSQL"))
    .catch(err => console.error("❌ Database connection error:", err));

const express = require("express");

const app = express();
const PORT = process.env.PORT || 3000;

app.get("/", (req, res) => {
    res.send("Artisan Printworks API is running!");
});

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});

