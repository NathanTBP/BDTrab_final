# Build

## Set up postgres
1. Install docker.
2. Use the above commands:
```sh
docker pull postgres
docker pull dpage/pgadmin4

docker network create -d bridge postgres-network

docker run --name postgres --network=postgres-network -e 'POSTGRES_PASSWORD=Postgres123!' -p 5432:5432 -v /home/breno/Documents/Programming/Javascript/Banco\ de\ Dados/DB:/var/lib/postgresql/data -d postgres

docker run --name pgadmin --network=postgres-network -p 15432:80 -e 'PGADMIN_DEFAULT_EMAIL=email@domain.com' -e 'PGADMIN_DEFAULT_PASSWORD=PgAdmin123!' -d dpage/pgadmin4
```
3. Change `$PATH$` to `.../DB/` directory.
4. Now go to `http://localhost:15432` and you should see pgAdmin page.

## Run front and backend
1. Run `npm i` on `frontend` and `backend` folders.
2. Run `node index.js` on backend folder.
3. Run `npm run dev` on frontend folder.