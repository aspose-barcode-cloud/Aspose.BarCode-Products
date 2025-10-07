SPARSE_REPO = ./sparse-repo/products.aspose.cloud

.PHONY: links
links: update-sparse-repo remove-broken-links
	ln -sv "$(SPARSE_REPO)/archetypes" | true
	ln -sv "$(SPARSE_REPO)/assets" | true
	ln -sv "$(SPARSE_REPO)/themes" | true

	ln -sv "$(SPARSE_REPO)/config-prod.toml" | true

	ln -sv ".$(SPARSE_REPO)/content/_index.md" "./content/_index.md" | true

.PHONY: update-sparse-repo
update-sparse-repo:
	./scripts/update-sparse-repo.bash

.PHONY: remove-broken-links
remove-broken-links:
	find . -type l ! -exec test -e {} \; -exec rm {} \;
