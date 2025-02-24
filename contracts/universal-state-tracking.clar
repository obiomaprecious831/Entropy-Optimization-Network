;; Universal State Tracking Contract

(define-data-var current-entropy uint u1000000000000)
(define-data-var last-update uint u0)

(define-public (update-entropy (new-entropy uint))
  (begin
    (asserts! (> new-entropy u0) (err u400))
    (var-set current-entropy new-entropy)
    (var-set last-update block-height)
    (ok true)
  )
)

(define-read-only (get-current-entropy)
  (ok (var-get current-entropy))
)

(define-read-only (get-last-update)
  (ok (var-get last-update))
)

(define-read-only (check-critical-level)
  (ok (< (var-get current-entropy) u1000000))
)

