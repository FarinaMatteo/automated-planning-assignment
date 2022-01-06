(define (domain injured-people-environment)
    (:requirements :typing :equality :negative-preconditions :existential-preconditions)
    (:types
        loc
        person
        food medicine - crate
        robot
    ) 
    (:constants agent - robot)
    (:predicates 
        (injured ?p)
        
        ; localization predicates
        (robot-at ?r - robot ?l - loc)
        (person-at ?p - person ?l - loc)
        (crate-at ?c - crate ?l - loc)
        
        ; action-based predicates
        (has-crate ?p - person ?c - crate) ; person p has crate c
        (carrying ?r ?c) ; robot r is carrying crate c

        ; predicates expressing intrinsic properties of entities
        (free ?r) ; robot r is free, meaning it is not carrying any crate
        (delivered ?c) ; crate c has been delivered (cannot be loaded on a robot)
    )

    ; move the robot ?r from location ?src to location ?dst
    (:action Move
        :parameters (?r - robot ?src ?dst - loc)
        :precondition (and
            ; actual action constraints
            (robot-at ?r ?src) (not (= ?src ?dst))
        )
        :effect (and 
            (not (robot-at ?r ?src)) ; robot is not at the source location anymore
            (robot-at ?r ?dst) ; robot is at the destination location after moving
        )
    
    )

    ; load the crate ?c onto robot ?r at location ?l
    (:action Load 
        :parameters (?r - robot ?c - crate ?l - loc)
        :precondition (and 
            (robot-at ?r ?l) (crate-at ?c ?l) ; location constraints
            (not (carrying ?r ?c)) (free ?r) ; ensure the robot can load the crate
            (not (delivered ?c)) ; ensure the crate can be loaded onto the robot
        )
        :effect (and 
            (carrying ?r ?c) (not (free ?r)) ; the robot is actually holding the crate, so it is not free anymore
        )
    )

    ; deliver the content of crate ?c to person ?p from robot ?r when at the same location ?l
    (:action Unload
        :parameters (?r - robot ?c - crate ?p - person ?l - loc)
        :precondition (and 
            (robot-at ?r ?l) (person-at ?p ?l) ; location constraints
            (carrying ?r ?c) ; make sure we are not trying to unload a crate we don't have!
        )
        :effect (and 
            (not (carrying ?r ?c)) (free ?r) ; the robot is not carrying the crate anymore, so it is free
            (has-crate ?p ?c) (crate-at ?c ?l) ; the crate has been delivered to the person, so it is his/hers property at the same loc.
            (delivered ?c) ; since the person needs the content of the crate, it cannot be reused. So, mark it as delivered.
        )
    )
)