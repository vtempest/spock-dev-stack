
<img src="https://i.imgur.com/2W62ySQ.png"  height="300px">  <img src="https://i.imgur.com/eRoKfA5.png"  height="300px">

#### Elegantly Simple, Functionally Brilliant

Full-stack all-in-one in 3 containers
* SvelteKit real-world demo of OAuth, posts, comments, profiles, likes, followers
* Pocketbase SQL, admin dashboard
* Caddy https router

## Spock Dev Stack Docs

- [Svelte](https://svelte.dev/examples/hello-world) structure for reactive interface components 
- [Pocketbase](https://pocketbase.io/docs/js-overview/) sqlite db toolkit, admin panel, auth, api docs, ORM rules, migrations, files, js extensions 
- [OAuth2](https://developers.google.com/identity/protocols/oauth2) Google Signin user authentication
- [Caddy](https://caddyserver.com/docs/) https server routing to containers with [caddy-docker-proxy](https://github.com/lucaslorentz/caddy-docker-proxy) in one file
- [Svelte Kit](https://kit.svelte.dev) api server with server-side render
- [docker compose](https://docs.docker.com/compose/gettingstarted/) manage containers in one file
- [ESLint](https://github.com/dustinspecker/awesome-eslint)/[Prettier](https://prettier.io) code style
- [Vite](https://vitejs.dev) bundle compiler


#### Optional Extras
- [Awesome Svelte Libraries](https://github.com/TheComputerM/awesome-svelte#ui-libraries)
  - [DaisyUI](https://daisyui.com/docs/install/)
  - [SkeletonUI](https://www.skeleton.dev/components/app-rail)
  - [Flowbite](https://flowbite-svelte.com/docs/pages/introduction)
  - [Framework7 Mobile](https://framework7.io/svelte/kitchen-sink)
- [PostgreSQL Supabase](https://supabase.com/docs/guides/getting-started/quickstarts/sveltekit) - alternative  db admin with  cloud or selfhosted containers
- [Icon sets](https://www.svgrepo.com/collections)

## Install

1. Clone to localhost or server 
2. `mv .env.example .env` and set the domain in `.env` 
3. `docker network create caddy`
4. `docker-compose up -d` 
5. Go to  `localhost:8090/_` or with caddy `api.localhost/_` or on server `api.domain.com/_` and setup admin login
6. Import Collections, load `pb_schema.json`
7. Auth providers, get id/secret from [Google](https://console.cloud.google.com/apis/credentials) 
8. Set OAuth origin `http://localhost` and `http://localhost:5173` on local or `https://domain.com` on server
9. Set redirect `http://localhost:8090/api/oauth2-redirect` or `https://api.domain.com/api/oauth2-redirect`
10. Develop app running on `app.domain.com` or `localhost:5173`



#### \\\\// Build fast and scale \\\\//
