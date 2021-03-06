module Docs
  class Erlang < FileScraper
    self.type = 'erlang'
    self.root_path = 'doc/index.html'
    self.links = {
      home: 'https://www.erlang.org/',
      code: 'https://github.com/erlang/otp'
    }

    html_filters.insert_after 'container', 'erlang/pre_clean_html'
    html_filters.push 'erlang/entries', 'erlang/clean_html'

    options[:only_patterns] = [
      /\Alib/,
      /\Adoc\/\w+\//,
      /\Aerts.+\/html/
    ]

    options[:skip_patterns] = [
      /pdf/,
      /release_notes/,
      /result/,
      /java/,
      /\.erl\z/,
      /\/html\/.*_app\.html\z/,
      /_examples\.html\z/,
      /\Alib\/edoc/,
      /\Alib\/erl_docgen/,
      /\Alib\/hipe/,
      /\Alib\/ose/,
      /\Alib\/test_server/,
      /\Alib\/jinterface/,
      /\Alib\/wx/,
      /\Alib\/ic/,
      /\Alib\/Cos/i
    ]

    options[:attribution] = <<-HTML
      &copy; 2010&ndash;2017 Ericsson AB<br>
      Licensed under the Apache License, Version 2.0.
    HTML

    version '21' do
      self.release = '21.0'
    end

    version '20' do
      self.release = '20.3'
    end

    version '19' do
      self.release = '19.3'
    end

    version '18' do
      self.release = '18.3'
    end

    def get_latest_version(opts)
      doc = fetch_doc('https://www.erlang.org/downloads', opts)
      doc.at_css('.col-lg-3 > ul > li').content.strip.sub(/OTP /, '')
    end
  end
end
