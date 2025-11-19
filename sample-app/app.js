const express = require("express");
const Redis = require("ioredis");

const app = express();
const redis = new Redis({
  host: process.env.REDIS_HOST || "redis"
});

app.get("/", async (req, res) => {
  await redis.set("msg", "Hello from Redis + Node App");
  const msg = await redis.get("msg");
  res.send({ status: "OK", message: msg });
});

app.listen(3000, () => console.log("Sample app running on port 3000"));
