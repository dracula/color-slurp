#! /usr/bin/env brew ruby
system "brew tap dracula/install --quiet"
$LOAD_PATH.unshift *Tap.cmd_directories
require "dracula-yaml-json"

Homebrew.dracula_yaml_json do |theme|
  theme[:version] = 1
  spec = theme[:spec].except :blue, :magenta, :bright_black

  theme[:colors] = spec.transform_keys(&:titlecase).map do |name, hex|
    hex.delete_prefix! "#"
    hex = hex.chars.map { |h| h * 2 }.join if hex.length == 3

    r, g, b = hex.scan(/\h{2}/).map { |hh| (hh.hex / 255.0).round(8).to_s }

    next { name: name, r: r, g: g, b: b, a: "1.0" }
  end
  next theme
end
