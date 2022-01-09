(define (domain delivery)
  (:requirements :strips :typing) 
  (:types carrier
          agent - vehicle
          crate
          vehicle - physobj
          base
          location - place
          city
          place 
          physobj - object)
  
  (:predicates 	(in-city ?p - place ?city - city) ; person in the city
		(at ?obj - physobj ?loc - place)
		(in ?pkg - crate ?veh - vehicle))
  
(:action LOAD-CARRIER
   :parameters    (?pkg - crate ?carrier - carrier ?loc - place)
   :precondition  (and (at ?carrier ?loc) (at ?pkg ?loc))
   :effect        (and (not (at ?pkg ?loc)) (in ?pkg ?carrier)))

(:action LOAD-AGENT
  :parameters   (?pkg - crate ?agent - agent ?loc - place)
  :precondition (and (at ?pkg ?loc) (at ?agent ?loc))
  :effect       (and (not (at ?pkg ?loc)) (in ?pkg ?agent)))

(:action UNLOAD-CARRIER
  :parameters   (?pkg - crate ?carrier - carrier ?loc - place)
  :precondition (and (at ?carrier ?loc) (in ?pkg ?carrier))
  :effect       (and (not (in ?pkg ?carrier)) (at ?pkg ?loc)))

(:action UNLOAD-AGENT
  :parameters    (?pkg - crate ?agent - agent ?loc - place)
  :precondition  (and (in ?pkg ?agent) (at ?agent ?loc))
  :effect        (and (not (in ?pkg ?agent)) (at ?pkg ?loc)))

(:action MOVE-CARRIER
  :parameters (?carrier - carrier ?loc-from - place ?loc-to - place ?city - city)
  :precondition
   (and (at ?carrier ?loc-from) (in-city ?loc-from ?city) (in-city ?loc-to ?city))
  :effect
   (and (not (at ?carrier ?loc-from)) (at ?carrier ?loc-to)))

(:action FLY-AGENT
  :parameters (?agent - agent ?loc-from - base ?loc-to - base)
  :precondition
   (at ?agent ?loc-from)
  :effect
   (and (not (at ?agent ?loc-from)) (at ?agent ?loc-to)))
)
