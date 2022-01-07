(define (domain delivery-p2)
  (:requirements :strips :fluents )

  (:predicates 
  				(crate ?c) 
				(agent ?a) 
				(at-location ?p) ; by default we mean here that person is at loction in order to avoide redundancy
				(at ?t ?l) 
				(in ?c ?a) 
	       		(capacity ?a ?n) 
	)

  (:functions (capacity ?r) ; declare function with capacity 
  )

  (:action load ; loading crate from loaction by agent 
	   :parameters 		(?c ?r ?l)
	   :precondition 	(and (crate ?c) (agent ?r) (at-location ?l)
	   					(at ?c ?l) (at ?r ?l) (< (capacity ?r) 4) ; as it should load 4 crate 
				  		)
	   :effect 			(and (not (at ?c ?l)) (in ?c ?r) (increase (capacity ?r) 1) ; increment 1 until it reach to max 4 quantity as per decleration
	   					)
	)

  (:action unload ; unloading crate into desire location where person is located
	   :parameters 		(?c ?r ?l)
	   :precondition 	(and (crate ?c) (agent ?r) (at-location ?l)
			    		(in ?c ?r) (at ?r ?l) (> (capacity ?r) 0)
				 		 )
	   :effect 			(and (not (in ?c ?r)) (at ?c ?l) (decrease (capacity ?r) 1) ; decrease 1 when unload and so on
	   					)
	)

  (:action fly ; as helicopter to be fly from source to destination 
	   :parameters 		(?r ?dep ?dst)
	   :precondition 	(and (agent ?r) (at-location ?dep) (at-location ?dst)(at ?r ?dep)
				   		)
	   :effect 			(and (not (at ?r ?dep)) (at ?r ?dst) 
	   					)
	)

  )
