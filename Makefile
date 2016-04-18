jsonl2csv: FORCE
	dub --compiler=gdc

local-install:
	dub build --build=release
	cp jsonl2csv ~/.bin/

docker-build: FORCE
	docker build -t beijaflorio/jsonl2csv . # :`git rev-parse HEAD` .

FORCE:
