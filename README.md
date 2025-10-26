# Sales Analysis — Prueba-SQL-PYTHON-LIBRERIAS

Short, reproducible notebook pipeline for loading sales data from PostgreSQL, cleaning and transforming it, computing KPIs and producing visualizations.

## Project structure
```
Prueba-SQL-PYTHON-LIBRERIAS/
├─ notebooks/
│  └─ analisis.ipynb         # Main analysis notebook (uses data/conexion.ipynb)
├─ data/
│  └─ conexion.ipynb         # Connection helper (creates SQLAlchemy `engine`)
├─ src/
│  └─ visualizacion.ipynb    # Visualization examples / demos
├─ README.md                 # This file
```

## Contents
- notebooks/analisis.ipynb — main analysis notebook (uses connection defined in `data/conexion.ipynb`)
- data/conexion.ipynb — connection helper (creates `engine`)
- src/visualizacion.ipynb — visualization examples
- README.md — this file

## Requirements
- Python 3.8+
- Recommended packages: pandas, numpy, sqlalchemy, psycopg2-binary, matplotlib, seaborn, jupyter
- Example install (Windows):
  - python -m venv .venv
  - .venv\Scripts\activate
  - pip install -r requirements.txt
  - (or) pip install pandas numpy sqlalchemy psycopg2-binary matplotlib seaborn jupyter

## Quick start (Windows)
1. Activate venv:
   .venv\Scripts\activate
2. Start Jupyter:
   jupyter lab
3. Run notebooks in the same kernel, top-to-bottom:
   - Execute `data/conexion.ipynb` (defines `engine`) or ensure `data/conexion.py` exposes `engine`.
   - Execute `notebooks/analisis.ipynb` cells sequentially.

## Connection
- The project currently uses `data/conexion.ipynb` to create a SQLAlchemy `engine`.
- Recommended: convert to `data/conexion.py` with:
  ```py
  engine = create_engine("postgresql+psycopg2://USER:PASSWORD@HOST:PORT/DBNAME")
  ```
- Optionally use environment variables (DB_USER, DB_PASSWORD, DB_HOST, DB_PORT, DB_NAME).

## Notes & Best Practices
- Execute notebooks in order to ensure `engine` and `df` are defined.
- CELL 2 in the analysis notebook builds SQL dynamically and includes fallbacks if some columns/tables are missing (e.g., `category_name`, `product_cost`).
- If you get SQL errors about missing columns, inspect `select_sql` in CELL 2 or run the inspection queries included.

## Troubleshooting
- "engine not defined": run `data/conexion.ipynb` or create/import `data/conexion.py`.
- SQL errors (UndefinedColumn): adjust dynamic select logic in CELL 2 or update DB schema.
- Connection/permissions: confirm PostgreSQL is running and credentials are correct.

## Suggested next steps
- Add `requirements.txt`.
- Convert connection helper to `data/conexion.py`.
- Add unit tests for data-processing functions if refactored out of notebooks.
- Export key aggregates (CSV) for reporting.

## Author
- Name: Daniela Martinez Quinto
- Contact: Daniela-m-quinto@outlook.es

## License
- MIT (change as needed)