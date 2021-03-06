HTDOCS = htdocs
ATLAS = $(HTDOCS)/atlas.png
SPRITES = sprites/*
WEBROOT = hhsw.de@ssh.strato.de:sites/proto/hophop
OPTIONS = \
	--recursive \
	--links \
	--update \
	--delete-after \
	--times \
	--compress

live: $(ATLAS)
	rsync $(OPTIONS) $(HTDOCS)/* $(WEBROOT)

$(ATLAS): $(SPRITES)
	cd $(HTDOCS) && \
		MAX_SIZE=256 \
			MIN_SIZE=256 \
			MARGIN=1 \
			mkatlas ../$(SPRITES) | \
		patchatlas index.html
	convert $(ATLAS) \
		-background black \
		-alpha Remove $(ATLAS) \
		-compose Copy_Opacity \
		-composite $(ATLAS)
