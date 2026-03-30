# Proyecto dbt-citibike-nyc
## Creación del proyecto.
- Para crear este proyecto partimos del contenedor que se nos proporcionó y seguimos los siguientes pasos.
>  1. Creamos la carpeta dbt-projec
>  2. Copiamos el Dockerfile y doccker-compose.ym proporcionados.
>  3. Cramos el entornos con el comando: docker-compose up -d --build
>  4. Entramos en el contenedor: docker exec -i dbt_demo bash
>>  4.1 Inicializamos el proyecto : init citibikenyc 

 ## Utilización del proyecto

Más a delante se inica como proceder para limpiar los datos previos para proximas ejecuciones.
- dbt run
- dbt test


## Recursos utilizados:
- Para la implementación del proyecto se ha seleccionado la api proporcionada por el servicio de alquiler de bicicletas de New York y
- (https://docs.getdbt.com/docs/introduction)
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices


Como limpiar la BBDD duck.db

cd /dbt_project/citibikenyc

# 1. Eliminar la base de datos completa (reset total)
rm -f dev.duckdb

# 2. (Opcional pero recomendado) Limpiar caché de dbt
dbt clean

# 3. Ejecutar el pipeline desde cero
dbt run
