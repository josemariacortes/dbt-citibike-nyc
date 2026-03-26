Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
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