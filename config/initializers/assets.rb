# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
 Rails.application.config.assets.precompile += ['00_bootstrap.min.css', '01_font_e_style.css', '02_linea-font.css', '03_font-awesome.min.css', '04_slick.css', '05_magnific-popup.css', '06_animate.css', '07_main.css', '08_responsive_test.css', 'style.css']
 