const pluginRss = require("@11ty/eleventy-plugin-rss");
const { DateTime } = require("luxon");
module.exports = function (eleventyConfig) {
  // ✅ Filtro date para usar en layouts
eleventyConfig.addFilter("date", (value, format = "yyyy") => {
  const date = value === "now" ? new Date() : new Date(value);
  return DateTime.fromJSDate(date).toFormat(format);
});
eleventyConfig.addLiquidFilter("date", (value, format = "%Y-%m-%d") => {
    const date = value === "now" ? new Date() : new Date(value);
    return DateTime.fromJSDate(date).toFormat(
      format
        .replace("%Y", "yyyy")
        .replace("%m", "MM")
        .replace("%d", "dd")
    );
  });
  // Copia styles.css directamente al output
  eleventyConfig.addPassthroughCopy("styles.css");

  return {
    templateFormats: ["html", "njk", "md"],
    dir: {
      input: ".",
      includes: "_includes",
      data: "_data"
    },
  };
};
