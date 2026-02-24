local lint = require("lint")
lint.linters_by_ft = { vue = { "eslint" }, clojure = { "clj-kondo" }, ["yaml.ansible"] = { "ansible-lint" } }
