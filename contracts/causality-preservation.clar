;; Causality Preservation Contract

(define-data-var next-event-id uint u0)

(define-map causal-events
  { event-id: uint }
  {
    description: (string-utf8 256),
    timestamp: uint,
    energy-change: int
  }
)

(define-public (record-event (description (string-utf8 256)) (timestamp uint) (energy-change int))
  (let
    ((event-id (+ (var-get next-event-id) u1)))
    (var-set next-event-id event-id)
    (map-set causal-events
      { event-id: event-id }
      {
        description: description,
        timestamp: timestamp,
        energy-change: energy-change
      }
    )
    (ok event-id)
  )
)

(define-read-only (get-event (event-id uint))
  (ok (unwrap! (map-get? causal-events { event-id: event-id }) (err u404)))
)

(define-read-only (check-causality (event-id-1 uint) (event-id-2 uint))
  (let
    (
      (event-1 (unwrap! (map-get? causal-events { event-id: event-id-1 }) (err u404)))
      (event-2 (unwrap! (map-get? causal-events { event-id: event-id-2 }) (err u404)))
    )
    (ok (< (get timestamp event-1) (get timestamp event-2)))
  )
)

