# Proyecto dbt-citibike-nyc
## Creación del proyecto.
- Para crear este proyecto partimos del contenedor que se nos proporcionó y seguimos los siguientes pasos.
>  1. Creamos la carpeta dbt-projec
>  2. Copiamos el Dockerfile y doccker-compose.ym proporcionados.
>  3. Cramos el entornos con el comando: docker-compose up -d --build
>  4. Entramos en el contenedor: docker exec -i dbt_demo bash
>>  4.1 Inicializamos el proyecto : init citibikenyc 

## Recursos utilizados:
- Para la implementación del proyecto se ha seleccionado llos datos de la empresa de alquiler del servicio de alquiler de bicicletas de New York y Jersey City
- Como framework dbt (https://docs.getdbt.com/docs/introduction)
- Como base de dat duckdb: (https://duckdb.org/)
- Como fuente de datos, se han descargado ficheros CSV de los meses de mayo. 

## Que hace el proyecto
### 01- Sources, carga los csv en dos vistas diferentes
>- Datos de New York (solo cargamos el primer fichero del mes)
>- Datos de Jersey City

### 02- Staging, carga los csv en una única vista 
>- Crea una nueva vista con la únion de las vistas anteriores.

### 03- Limpieza de los datos en cascada y los guardamos en una nueva vista consistente en:
>- Eliminamos duplicados.
>- Descartamos datos que no tengan origen o destino válido.
>- Descartamos fechas incorrectas. (Solo controlamos que sean del año 2024)
>- Descartamos recorridos que tengan mismo origen y destino (puede eliminar casos correctos, pero no hemos profundizado).

### 04- Eriquecimiento, tambien los guardamos en una vista
>- Añadimos información calculada del viaje
>>- Duracción del viaje.
>>- Distancia recorrida.

### 5- Structural
>- Añadimos información de auditoria:
>>- Id del proceso
>>- Fecha de inserción de los datos.

### 99- Datamark. En este paso ya guardamos los datos en tablas
>- Viajes, datos de los viajes eliminando información redundate como los nombres de las estaciones.
>- Estaciones, relaciona la estación con su identificador, y le asignamos una hubicación. para las tablas de Newyork usamos la media.
>- Time, autogenerada para asociar la hora del viaje con la parte del día.
>- Date, autogenerada para poder agrupar las fechas con el día.

## Ejecución del proyecto

>> Es recomendable hacer una limpieza del enetorno si ya se ha ejecutado/depurado anteriormente (descrito mñas adelante).
- docker exec -it dbt_demo bash
- cd citibikenyc
  Ejecutamos los procesos.
- dbt run
- 
## Testeamos  y nalizamos la solución
- dbt test
- dbt docs generate
- dbt docs serve --host 0.0.0.0 --port 8080




### Como limpiar la BBDD duck.db

cd /dbt_project/citibikenyc
#### 1. Eliminar la base de datos completa (reset total)
rm -f dev.duckdb

#### 2. (Opcional pero recomendado) Limpiar caché de dbt
dbt clean

### 3. Ejecutar el pipeline desde cero
dbt run

# Analisis de Datos Final

Incluidos en el directorio tenemos tres consultas
>1_top_ten_start_station
>>- Las diez estaciones de salida con más viajes.
>2_amout_user_part_day
>>- Número de viajes por parte del día.
>3_user_type_avg
>>- Media de los viajes por tipo de usuario.




