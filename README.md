# Next.js + Flask + Dash App with Nginx Proxy
This repository contains a template for building a website using Next.js with Nginx reverse proxy and a Flask API with a Dash application. You can easily create a site that includes a link to a dashboard, which will open the Dash dashboard upon clicking.

## Project Structure
- The `flask` folder contains the Flask application and Dash applications. You can add your own Dash applications and connect them to Flask in `app.py`.
- The `nextjs` folder contains the Next.js website. The entry point is in `app/page.tsx`, which includes the homepage and a test link to the Dash dashboards. You can add your own pages and components in the `app` directory.  
```
nextjs/  
├── app/  
│   ├── globals.css       // Stylesheet  
│   ├── layout.tsx        // Main layout for the application  
│   └── page.tsx          // Homepage  
├── public/               // Folder for static files   
├── package.json          // Dependency file   
└── ...
```
- The `nginx` folder contains the Nginx configuration file, which will set up the reverse proxy for both Next.js and Flask.
- In the root of the project, you will find Docker Compose files that allow you to run the project in Docker containers. The naming of the Docker Compose files indicates their purpose.

## Usage

- To configure Nginx, edit the `nginx.conf` file in the `nginx` folder.
- You can run the project in development mode or production mode.
- There is also the option to run everything in a single container or in separate containers.
- The Flask application listens on port 5000.
- The Next.js application listens on port 3000.

### Steps to Get Started

1. Clone the repository and navigate to the root folder of the project.
 
 ```bash
 git clone <repository-url>
 cd <project-root>
```
2. Run the desired Docker Compose command based on your needs (development or production).

```bash
docker-compose -f docker-compose.dev.yml up --build # For development in separate containers
docker-compose -f docker-compose.prod.yml up --build # For production in separate containers
```
Open http://localhost with your browser to see the result.
