(define (domain delivery)
  (:requirements :strips)

  (:predicates (LOC ?x) ; we assume that person at the location in order to avoide redundancy 
  			(CRATE ?x)
	        (AGENT ?x)
			(at-rob ?x)
			(at-crate ?x ?y)
			(free ?x) 
			(carry ?x ?y)
	)

  (:action move
		:parameters (?l1 ?l2)
		:precondition 	(and (LOC ?l1) (LOC ?l2)
						(at-rob ?l1)
						)
		:effect (and (at-rob ?l2)
				(not (at-rob ?l1))
				)
	)

  (:action pick-up
	   :parameters (?c ?l ?a)
	   :precondition 	(and (CRATE ?c) (LOC ?l) (AGENT ?a)
			      		(at-crate ?c ?l) (at-rob ?l) (free ?a)
						)
	   :effect (and (carry ?a ?c) (not (at-crate ?c ?l))
					(not (free ?a))
				)
	)

  (:action drop
	   :parameters (?c ?l ?a)
	   :precondition 	(and (CRATE ?c) (LOC ?l) (AGENT ?a)
			      		(carry ?a ?c) (at-rob ?l)
						)
	   :effect 		(and (at-crate ?c ?l) (free ?a)
					(not (carry ?a ?c))
					)
	)
  )
