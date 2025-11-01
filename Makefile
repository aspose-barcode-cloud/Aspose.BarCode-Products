SPARSE_REPO = ./sparse-repo/products.aspose.cloud

.PHONY: init
init: update-sparse-repo links
	npm ci

.PHONY: remove-broken-links
remove-broken-links:
	@echo "Removing broken symlinks..."
	@find . -type l ! -exec test -e {} \; -exec rm {} \;

.PHONY: links
links: remove-broken-links
	@echo "Recreating symlinks..."
	@ln -sv "$(SPARSE_REPO)/archetypes" | true
	@ln -sv "$(SPARSE_REPO)/assets" | true
	@ln -sv "$(SPARSE_REPO)/themes" | true

	@ln -sv "$(SPARSE_REPO)/config-prod.toml" | true

	@ln -sv ".$(SPARSE_REPO)/content/_index.md" "./content/_index.md" | true

.PHONY: update-sparse-repo
update-sparse-repo:
	./scripts/update-sparse-repo.bash

.PHONY: npm-update
npm-update:
	npm run update

.PHONY: update
update: update-sparse-repo npm-update

.PHONY: site
site:
	./scripts/hugo-server.bash --dont-serve

.PHONY: verify-urls
verify-urls:
	./scripts/verify-generated-urls.bash
