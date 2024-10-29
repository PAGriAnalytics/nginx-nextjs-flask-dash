import type { NextConfig } from "next";

/** @type {import('next').NextConfig} */
const nextConfig = {
  // rewrites: async () => {
  //   return [
  //     {
  //         source: "/api/:path*",
  //         destination: "http://0.0.0.0:5000/api/:path*", // Proxy to Flask API
  //     },
  //   ]
  // },
}

module.exports = nextConfig
