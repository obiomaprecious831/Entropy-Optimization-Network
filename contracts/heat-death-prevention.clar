;; Heat Death Prevention Contract

(define-data-var entropy-threshold uint u1000000)
(define-data-var energy-injection-rate uint u1000)
(define-data-var last-injection-time uint u0)

(define-public (set-entropy-threshold (new-threshold uint))
  (begin
    (var-set entropy-threshold new-threshold)
    (ok true)
  )
)

(define-public (set-energy-injection-rate (new-rate uint))
  (begin
    (var-set energy-injection-rate new-rate)
    (ok true)
  )
)

(define-public (inject-energy)
  (let
    ((current-time block-height))
    (asserts! (> current-time (var-get last-injection-time)) (err u403))
    (var-set last-injection-time current-time)
    (ok (var-get energy-injection-rate))
  )
)

(define-read-only (get-entropy-threshold)
  (ok (var-get entropy-threshold))
)

(define-read-only (get-energy-injection-rate)
  (ok (var-get energy-injection-rate))
)

(define-read-only (get-last-injection-time)
  (ok (var-get last-injection-time))
)

(define-read-only (check-injection-needed (current-entropy uint))
  (ok (< current-entropy (var-get entropy-threshold)))
)

