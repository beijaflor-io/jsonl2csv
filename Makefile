jsonl2csv: FORCE
	dub --compiler=gdc

docker-build: FORCE
	docker build -t beijaflorio/jsonl2csv . # :`git rev-parse HEAD` .

FORCE:
