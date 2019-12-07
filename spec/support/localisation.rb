DEFAULT_LOCALE = :en

def with_localisations(localisations, locale: DEFAULT_LOCALE)
  unless locale.eql?(DEFAULT_LOCALE)
    I18n.available_locales = [DEFAULT_LOCALE, locale]
    I18n.locale = locale
  end
  I18n.backend.store_translations(locale, localisations[locale])

  yield
ensure
  I18n.available_locales = DEFAULT_LOCALE
  I18n.locale = DEFAULT_LOCALE

  I18n.reload!
end
