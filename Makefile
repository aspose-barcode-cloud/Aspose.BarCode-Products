SPARSE_REPO = ./sparse-repo/products.aspose.cloud


.PHONY: remove-broken-links
remove-broken-links:
	find . -xtype l -exec rm {} \;

.PHONY: links
links: remove-broken-links
	ln -sv "$(SPARSE_REPO)/archetypes" | true
	ln -sv "$(SPARSE_REPO)/assets" | true
	ln -sv "$(SPARSE_REPO)/themes" | true

	ln -sv "$(SPARSE_REPO)/config-prod.toml" | true

	ln -sv ".$(SPARSE_REPO)/content/_index.md" "./content/_index.md" | true
