(define (domain injured-people-environment)
    (:requirements :typing :equality :negative-preconditions :disjunctive-preconditions)
    (:types
        loc - object
        person - object
        crate - object
        food medicine - crate
        robot - object
    ) 
    (:constants agent - robot)
    (:predicates 
        
        ; localization predicates
        (robot_at ?r - robot ?l - loc)
        (person_at ?p - person ?l - loc)
        (crate_at ?c - crate ?l - loc)
        
        ; action-based predicates
        (has_crate ?p - person ?c - crate) ; person p has crate c
        (carrying ?r ?c) ; robot r is carrying crate c

        ; predicates expressing intrinsic properties of entities
        (free ?r) ; robot r is free, meaning it is not carrying any crate
    )

    ; move the robot ?r from location ?src to location ?dst
    (:action move
        :parameters (?r - robot ?src ?dst - loc)
        :precondition (and
            ; actual action constraints
            (robot_at ?r ?src) (not (= ?src ?dst))
        )
        :effect (and 
            (not (robot_at ?r ?src)) ; robot is not at the source location anymore
            (robot_at ?r ?dst) ; robot is at the destination location after moving
        )
    )

    ; load the crate ?c onto robot ?r at location ?l
    (:action load 
        :parameters (?r - robot ?c - crate ?l - loc)
        :precondition (and 
            (robot_at ?r ?l) (crate_at ?c ?l) ; location constraints
            (not (carrying ?r ?c)) (free ?r) ; ensure the robot can load the crate
        )
        :effect (and 
            (carrying ?r ?c) (not (free ?r)) ; the robot is actually holding the crate, so it is not free anymore
            (not (crate_at ?c ?l))
        )
    )

    ; deliver the content of crate ?c to person ?p from robot ?r when at the same location ?l
    (:action unload
        :parameters (?r - robot ?c - crate ?p - person ?l - loc)
        :precondition (and 
            (robot_at ?r ?l) (person_at ?p ?l) ; location constraints
            (carrying ?r ?c) ; make sure we are not trying to unload a crate we don't have!
        )
        :effect (and 
            (not (carrying ?r ?c)) (free ?r) ; the robot is not carrying the crate anymore, so it is free
            (has_crate ?p ?c) ; the crate has been delivered to the person
        )
    )
)