return {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
    flags = {
      debounce_text_changes = 150,
    },
  },
}
