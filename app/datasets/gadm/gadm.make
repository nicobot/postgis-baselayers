install: uninstall
	@echo STATUS=Downloading
	mkdir -p src tmp
	cd src && wget -q https://geodata.ucdavis.edu/gadm/gadm4.1/gadm_410-gpkg.zip

	@echo STATUS=Importing
	unzip -o src/gadm_410-gpkg.zip -d tmp
	ogr2ogr -f PostgreSQL -overwrite $(POSTGRES_OGR) -lco SCHEMA=gadm tmp/gadm_410.gpkg

uninstall:
	@echo STATUS=Uninstalling
	psql "$(POSTGRES_URI)" -c 'DROP TABLE IF EXISTS gadm.level0'
	psql "$(POSTGRES_URI)" -c 'DROP TABLE IF EXISTS gadm.level1'
	psql "$(POSTGRES_URI)" -c 'DROP TABLE IF EXISTS gadm.level2'
	psql "$(POSTGRES_URI)" -c 'DROP TABLE IF EXISTS gadm.level3'
	psql "$(POSTGRES_URI)" -c 'DROP TABLE IF EXISTS gadm.level4'
	psql "$(POSTGRES_URI)" -c 'DROP TABLE IF EXISTS gadm.level5'

