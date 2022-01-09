(define (domain delivery) 

(:requirements :typing :adl :durative-actions :fluents :timed-initial-literals)  
(:types agentarea location locatable - object
        agent crate - locatable) 

(:predicates  (at ?x - locatable ?l - location) 	     
              (in ?c - crate ?t - agent ?a - agentarea) 	     
              (connected ?x ?y - location)
              (free ?a - agentarea ?t - agent)
              (delivered ?c - crate ?l - location)
              (at-destination ?c - crate ?l - location)
              (closer ?a1 - agentarea ?a2 - agentarea)
              (deliverable ?c - crate ?l - location))

  (:functions (fly-time ?from ?to - location))

  (:durative-action load
  :parameters      (?c - crate ?t - agent ?a1 - agentarea ?l - location) ; 
  :duration        (= ?duration 4)
  :condition       (and (at start (at ?c ?l)) (at start (free ?a1 ?t))
                    (at start (forall (?a2 - agentarea)
                    (imply (closer ?a2 ?a1) (free ?a2 ?t)))
                    )
                    (over all (at ?t ?l)) 
                    (over all (forall (?a2 - agentarea)
                    (imply (closer ?a2 ?a1) (free ?a2 ?t)))
                    )
                  )
  :effect         (and (at start (not (at ?c ?l))) (at start (not (free ?a1 ?t)))
  	                (at end (in ?c ?t ?a1))
                  )
  )

  (:durative-action unload
  :parameters      (?c - crate ?t - agent ?a1 - agentarea ?l - location)
  :duration        (= ?duration 4)
  :condition       (and (at start (in ?c ?t ?a1))
  		 	            (at start (forall (?a2 - agentarea)
  			            (imply (closer ?a2 ?a1) (free ?a2 ?t))))
	                  (over all (at ?t ?l)) 
  		              (over all (forall (?a2 - agentarea)
  			            (imply (closer ?a2 ?a1) (free ?a2 ?t))))
                   )
  :effect 	       (and (at start (not (in ?c ?t ?a1))) (at end (free ?a1 ?t))
   	                (at end (at ?c ?l))
                   )
  )

  (:durative-action fly
  :parameters       (?t - agent ?from ?to - location)
  :duration         (= ?duration (fly-time ?from ?to))
  :condition        (and (at start (at ?t ?from)) (over all (connected ?from ?to))
                    )
  :effect           (and (at start (not (at ?t ?from))) (at end (at ?t ?to))
                    )
  )

  (:durative-action deliver-ontime
  :parameters       (?c - crate ?l - location)
  :duration         (= ?duration 4)
  :condition        (and (over all (at ?c ?l)) (at end (deliverable ?c ?l))
                    )
  :effect           (and (at end (not (at ?c ?l))) (at end (delivered ?c ?l)) 
                      (at end (at-destination ?c ?l))
                    )
  )

  (:durative-action deliver-anytime
  :parameters       (?c - crate ?l - location)
  :duration         (= ?duration 4)
  :condition        (and (at start (at ?c ?l)) (over all (at ?c ?l))
                    )
  :effect           (and (at end (not (at ?c ?l))) (at end (at-destination ?c ?l))
                    )
  )
) 

