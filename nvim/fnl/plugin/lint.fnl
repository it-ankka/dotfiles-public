(let [lint (require :lint)]
  (set lint.linters_by_ft {
                       :clojure :clj-kondo
                       }))
