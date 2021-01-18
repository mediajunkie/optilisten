const purgecss = require('@fullhuman/postcss-purgecss')
const cssnano = require('cssnano')
module.exports = {
  plugins: [
    require('autoprefixer'),
    cssnano({ preset: 'default' }),
    purgecss({
      content: ['./**/*.html'],
      defaultExtractor: content => content.match(/[\w-/:]+(?<!:)/g) || []
    })
  ]
}