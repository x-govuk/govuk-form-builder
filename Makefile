prefix=bundle exec
guide_dir=cd guide;
nanoc_internal_checks=internal_links stale mixed_content
nanoc_external_checks=external_links

check: ruby-lint rspec nanoc-check
nanoc-check: nanoc-check-internal

ruby-lint:
	${prefix} govuk-lint-ruby {lib,spec}
rspec:
	${prefix} rspec --format progress
nanoc-check-internal:
	${guide_dir} ${prefix} nanoc check ${nanoc_internal_checks}
nanoc-check-external:
	${guide_dir} ${prefix} nanoc check ${nanoc_internal_checks} ${nanoc_external_checks}
build:
	${prefix} gem build govuk_design_system_formbuilder.gemspec
clean:
	rm -rf guide/output/**/*
