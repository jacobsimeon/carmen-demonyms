require 'carmen'
require "carmen/demonyms/version"

module Carmen
  locale_path = File.expand_path("../../../locale", __FILE__)
  i18n_backend.append_locale_path(locale_path)

  class Country
    def demonym
      Carmen.i18n_backend.translate(path('demonym'))
    end
  end

  module Demonyms
  end
end
