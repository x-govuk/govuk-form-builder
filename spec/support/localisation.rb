def with_localisations(localisations, locale: :en)
  I18n.backend.store_translations(locale, localisations[locale])

  yield
ensure
  I18n.reload!
end
