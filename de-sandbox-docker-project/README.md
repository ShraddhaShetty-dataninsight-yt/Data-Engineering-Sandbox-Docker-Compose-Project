| Components | url |
|-----------|------|
| Jupyter | http://localhost:8888 (token: shraddha_youtube)|
| Spark UI (master) | http://localhost:8080 |
| Spark History | http://localhost:18080 |
| Kafka Schema Registry | http://localhost:8081 |
| Kafka Connect | http://localhost:8083 |
| Airflow | http://localhost:8082 (webserver on container port 8080)|
| Superset | http://localhost:8088 |
| MinIO Console | http://localhost:9001 (minioadmin/minioadmin)|


Notes, caveats & tips
- Resources: 5 Spark workers + other services need significant RAM/CPU. On a typical dev laptop you may want to reduce workers to 1–2 via docker-compose.override.yml.
- JARs: For Kafka read/write from Spark streaming you should put spark-sql-kafka-0-10_2.12 jar into spark/jars matching the Spark/Scala version.
- Airflow image official entrypoint needs extra one-time init steps (I provided commands above). If you want an automated init, I can add an init container/task to do it.
- Superset metadata config in this compose is minimal — for production use set a dedicated Postgres and secure credentials.
- Branding: I added a Jupyter token and some environment naming. If you want container labels or OCI metadata in the Dockerfiles I can add LABEL ... entries.
- Scaling: To scale workers later you can docker compose up -d --scale spark-worker=3 if the service is defined generically — with build per-worker entries we created five explicit services for convenience; if you'd like a single spark-worker service that is scalable, I can replace the five static worker services with one scalable definition.
