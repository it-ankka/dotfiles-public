(let [lint (require :lint)]
  (lint.linters_by_ft {
                       :clojure :clj-kondo
                       }))
